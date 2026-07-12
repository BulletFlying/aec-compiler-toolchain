"""Bootstrap PTX-to-AEC compiler for C1.

This is an O0-oriented baseline.  It supports the public PTX syntax subset
and emits Track-B raw 128-bit instructions by default.  It intentionally
raises on unsupported PTX rather than guessing.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from pathlib import Path
import re
import sys

from .isa import AECInstruction, PROFILES, TRACK_B_V1, ISAProfile, instructions_to_bytes
from .ptx import PTXInstruction, PTXProgram, parse_ptx


class CompileError(ValueError):
    """Raised when PTX cannot be lowered by the bootstrap compiler."""


TYPE_SIZE = {
    "u64": 8,
    "b64": 8,
    "f64": 8,
    "u32": 4,
    "b32": 4,
    "s32": 4,
    "f32": 4,
    "u16": 2,
    "f16": 2,
}


PTX_TO_AEC_TYPE = {
    "u64": "b64",
    "b64": "b64",
    "u32": "u32",
    "b32": "b32",
    "s32": "s32",
    "f32": "f32",
    "f16": "f16",
    "pred": "none",
}


SPECIAL_MOVE_TYPE = {
    "%tid": "u32",
    "%tid.x": "u32",
    "%tid.y": "u32",
    "%tid.z": "u32",
    "%ntid": "u32",
    "%ntid.x": "u32",
    "%ntid.y": "u32",
    "%ntid.z": "u32",
    "%ctaid": "u32",
    "%ctaid.x": "u32",
    "%ctaid.y": "u32",
    "%ctaid.z": "u32",
    "%nctaid": "u32",
    "%nctaid.x": "u32",
    "%nctaid.y": "u32",
    "%nctaid.z": "u32",
    "%laneid": "u32",
    "%warpid": "u32",
}


@dataclass
class LoweredProgram:
    instructions: list[AECInstruction]
    parameter_offsets: dict[str, int]


class RegisterAllocator:
    def __init__(self) -> None:
        self._next = 1
        self._mapping: dict[str, int] = {}
        self._temp_next = 240

    def reg(self, token: str, is_pair: bool = False) -> int:
        token = token.strip()
        if token not in self._mapping:
            if is_pair and self._next % 2 == 1:
                self._next += 1
            width = 2 if is_pair else 1
            if self._next + width - 1 >= 240:
                raise CompileError("bootstrap allocator ran out of registers")
            self._mapping[token] = self._next
            self._next += width
        return self._mapping[token]

    def temp(self) -> int:
        value = self._temp_next
        self._temp_next += 1
        if self._temp_next > 254:
            self._temp_next = 240
        return value


class Lowerer:
    def __init__(self, program: PTXProgram, profile: ISAProfile = TRACK_B_V1) -> None:
        self.program = program
        self.profile = profile
        self.regs = RegisterAllocator()
        self.instructions: list[AECInstruction] = []
        self.labels: dict[str, int] = {}
        self.pending_branches: list[tuple[int, str]] = []
        self.parameter_offsets = layout_parameters(program)

    def lower(self) -> LoweredProgram:
        for item in self.program.items:
            if isinstance(item, str):
                self.labels[item] = len(self.instructions)
                continue
            self._lower_instruction(item)
        self._patch_branches()
        return LoweredProgram(self.instructions, self.parameter_offsets)

    def _lower_instruction(self, inst: PTXInstruction) -> None:
        opcode_parts = inst.opcode.split(".")
        base = opcode_parts[0]
        if base == "ld" and len(opcode_parts) >= 3 and opcode_parts[1] == "param":
            self._lower_ld_param(inst, opcode_parts[2])
        elif base == "ld" and len(opcode_parts) >= 3 and opcode_parts[1] == "global":
            self._lower_ld_global(inst, opcode_parts[2])
        elif base == "st" and len(opcode_parts) >= 3 and opcode_parts[1] == "global":
            self._lower_st_global(inst, opcode_parts[2])
        elif base == "mov":
            self._lower_mov(inst, opcode_parts[1])
        elif base == "setp":
            self._lower_setp(inst, opcode_parts)
        elif base == "bra":
            self._lower_bra(inst)
        elif base == "ret":
            self._emit(AECInstruction("HALT"))
        elif base == "cvt":
            self._lower_cvt(inst, opcode_parts)
        elif base in {"add", "sub", "mul", "mad", "and", "shr"}:
            self._lower_alu(inst, opcode_parts)
        else:
            raise CompileError(f"line {inst.source_line}: unsupported PTX opcode {inst.opcode}")

    def _lower_ld_param(self, inst: PTXInstruction, ptx_type: str) -> None:
        self._require_operands(inst, 2)
        dest, source = inst.operands
        param_name = _strip_brackets(source)
        if param_name not in self.parameter_offsets:
            raise CompileError(f"line {inst.source_line}: unknown parameter {param_name}")
        address = self.regs.temp()
        self._emit(AECInstruction("LOADI", dest=address, imm=self.parameter_offsets[param_name]))
        dest_reg = self._ptx_reg(dest, is_pair=ptx_type in {"u64", "b64"})
        self._emit(
            AECInstruction(
                "LD",
                dtype=PTX_TO_AEC_TYPE[ptx_type],
                dest=dest_reg,
                src1=address,
                memory_space="pmem",
            )
        )

    def _lower_ld_global(self, inst: PTXInstruction, ptx_type: str) -> None:
        self._require_operands(inst, 2)
        dest, address = inst.operands
        addr_reg = self._ptx_reg(_strip_brackets(address), is_pair=True)
        if ptx_type == "u16":
            self._lower_u16_load(dest, addr_reg)
            return
        self._emit(
            AECInstruction(
                "LD",
                dtype=PTX_TO_AEC_TYPE[ptx_type],
                dest=self._ptx_reg(dest, is_pair=False),
                src1=addr_reg,
                memory_space="gmem",
            )
        )

    def _lower_u16_load(self, dest: str, addr_reg: int) -> None:
        dest_reg = self._ptx_reg(dest)
        aligned_addr = self.regs.temp()
        word = self.regs.temp()
        shift = self.regs.temp()
        mask = self._load_imm(0xFFFFFFFC)
        self._emit(AECInstruction("AND", dtype="u32", dest=aligned_addr, src1=addr_reg, src2=mask))
        self._emit(AECInstruction("LD", dtype="b32", dest=word, src1=aligned_addr, memory_space="gmem"))
        two = self._load_imm(2)
        self._emit(AECInstruction("AND", dtype="u32", dest=shift, src1=addr_reg, src2=two))
        three = self._load_imm(3)
        self._emit(AECInstruction("SHL", dtype="u32", dest=shift, src1=shift, src2=three))
        self._emit(AECInstruction("SHR", dtype="u32", dest=dest_reg, src1=word, src2=shift))
        low_half = self._load_imm(0xFFFF)
        self._emit(AECInstruction("AND", dtype="u32", dest=dest_reg, src1=dest_reg, src2=low_half))

    def _lower_st_global(self, inst: PTXInstruction, ptx_type: str) -> None:
        self._require_operands(inst, 2)
        address, source = inst.operands
        self._emit(
            AECInstruction(
                "ST",
                dtype=PTX_TO_AEC_TYPE[ptx_type],
                src1=self._ptx_reg(_strip_brackets(address), is_pair=True),
                src2=self._ptx_reg(source),
                memory_space="gmem",
                **self._guard(inst),
            )
        )

    def _lower_mov(self, inst: PTXInstruction, ptx_type: str) -> None:
        self._require_operands(inst, 2)
        dest, source = inst.operands
        dest_reg = self._ptx_reg(dest, is_pair=ptx_type in {"u64", "b64"})
        if source in self.profile.special_registers:
            self._emit(
                AECInstruction(
                    "CPY",
                    dtype=SPECIAL_MOVE_TYPE[source],
                    dest=dest_reg,
                    src1=self.profile.special_registers[source],
                    **self._guard(inst),
                )
            )
        elif _is_register(source):
            self._emit(
                AECInstruction(
                    "CPY",
                    dtype=PTX_TO_AEC_TYPE.get(ptx_type, ptx_type),
                    dest=dest_reg,
                    src1=self._ptx_reg(source, is_pair=ptx_type in {"u64", "b64"}),
                    **self._guard(inst),
                )
            )
        else:
            self._emit(AECInstruction("LOADI", dest=dest_reg, imm=_parse_immediate(source), **self._guard(inst)))

    def _lower_setp(self, inst: PTXInstruction, opcode_parts: list[str]) -> None:
        self._require_operands(inst, 3)
        if len(opcode_parts) != 3:
            raise CompileError(f"line {inst.source_line}: malformed setp opcode {inst.opcode}")
        compare, ptx_type = opcode_parts[1], opcode_parts[2]
        dest, lhs, rhs = inst.operands
        self._emit(
            AECInstruction(
                "CMPP",
                dtype=PTX_TO_AEC_TYPE[ptx_type],
                dest=_predicate_number(dest),
                src1=self._operand_reg(lhs),
                src2=self._operand_reg(rhs),
                compare=compare,
                **self._guard(inst),
            )
        )

    def _lower_bra(self, inst: PTXInstruction) -> None:
        self._require_operands(inst, 1)
        target = inst.operands[0]
        if inst.predicate is None:
            branch = AECInstruction("BR", imm=0)
        else:
            if inst.predicate_negated:
                raise CompileError(f"line {inst.source_line}: negated BRX is not directly supported yet")
            branch = AECInstruction("BRX", predicate=_predicate_number(inst.predicate), imm=0)
        self.pending_branches.append((len(self.instructions), target))
        self._emit(branch)

    def _lower_cvt(self, inst: PTXInstruction, opcode_parts: list[str]) -> None:
        self._require_operands(inst, 2)
        if len(opcode_parts) != 3:
            raise CompileError(f"line {inst.source_line}: malformed cvt opcode {inst.opcode}")
        dest_type, src_type = opcode_parts[1], opcode_parts[2]
        dest, source = inst.operands
        opcode = _conversion_opcode(dest_type, src_type)
        self._emit(
            AECInstruction(
                opcode,
                dtype=PTX_TO_AEC_TYPE[dest_type],
                cvt_src_type=PTX_TO_AEC_TYPE[src_type],
                dest=self._ptx_reg(dest, is_pair=dest_type in {"u64", "b64", "f64"}),
                src1=self._ptx_reg(source, is_pair=src_type in {"u64", "b64", "f64"}),
                **self._guard(inst),
            )
        )

    def _lower_alu(self, inst: PTXInstruction, opcode_parts: list[str]) -> None:
        self._require_operands(inst, 3 if opcode_parts[0] != "mad" else 4)
        base = opcode_parts[0]
        ptx_type = opcode_parts[-1]
        dest = inst.operands[0]
        sources = inst.operands[1:]

        if base == "mul" and len(opcode_parts) >= 3 and opcode_parts[1] == "wide":
            self._emit(
                AECInstruction(
                    "MUL",
                    dtype="u32",
                    dest=self._ptx_reg(dest, is_pair=True),
                    src1=self._operand_reg(sources[0]),
                    src2=self._operand_reg(sources[1]),
                    **self._guard(inst),
                )
            )
            return

        opcode = {"add": "ADD", "sub": "SUB", "mul": "MUL", "mad": "MAD", "and": "AND", "shr": "SHR"}[base]
        aec_type = PTX_TO_AEC_TYPE.get(ptx_type, ptx_type)
        if base == "mad":
            self._emit(
                AECInstruction(
                    opcode,
                    dtype=aec_type,
                    dest=self._ptx_reg(dest),
                    src1=self._operand_reg(sources[0]),
                    src2=self._operand_reg(sources[1]),
                    src3=self._operand_reg(sources[2]),
                    **self._guard(inst),
                )
            )
        elif base == "add" and ptx_type in {"u64", "b64"}:
            self._emit(
                AECInstruction(
                    "ADD",
                    dtype="u32",
                    dest=self._ptx_reg(dest, is_pair=True),
                    src1=self._operand_reg(sources[0], is_pair=True),
                    src2=self._operand_reg(sources[1], is_pair=True),
                    **self._guard(inst),
                )
            )
        else:
            self._emit(
                AECInstruction(
                    opcode,
                    dtype=aec_type,
                    dest=self._ptx_reg(dest),
                    src1=self._operand_reg(sources[0]),
                    src2=self._operand_reg(sources[1]),
                    **self._guard(inst),
                )
            )

    def _operand_reg(self, token: str, is_pair: bool = False) -> int:
        if _is_register(token):
            return self._ptx_reg(token, is_pair=is_pair)
        return self._load_imm(_parse_immediate(token))

    def _ptx_reg(self, token: str, is_pair: bool = False) -> int:
        token = token.strip()
        if token.startswith("%rd"):
            is_pair = True
        return self.regs.reg(token, is_pair=is_pair)

    def _load_imm(self, value: int) -> int:
        reg = self.regs.temp()
        self._emit(AECInstruction("LOADI", dest=reg, imm=value))
        return reg

    def _emit(self, inst: AECInstruction) -> None:
        self.instructions.append(inst)

    def _patch_branches(self) -> None:
        for index, label in self.pending_branches:
            if label not in self.labels:
                raise CompileError(f"unknown branch target label: {label}")
            self.instructions[index].imm = self.labels[label]

    def _guard(self, inst: PTXInstruction) -> dict[str, object]:
        if inst.predicate is None:
            return {}
        return {
            "predicate": _predicate_number(inst.predicate),
            "predicate_negated": inst.predicate_negated,
        }

    @staticmethod
    def _require_operands(inst: PTXInstruction, count: int) -> None:
        if len(inst.operands) != count:
            raise CompileError(
                f"line {inst.source_line}: {inst.opcode} expects {count} operands, got {len(inst.operands)}"
            )


def layout_parameters(program: PTXProgram) -> dict[str, int]:
    offsets: dict[str, int] = {}
    offset = 0
    for param in program.parameters:
        size = TYPE_SIZE.get(param.dtype)
        if size is None:
            raise CompileError(f"unsupported parameter type: {param.dtype}")
        alignment = min(size, 8)
        if offset % alignment:
            offset += alignment - (offset % alignment)
        offsets[param.name] = offset
        offset += size
    return offsets


def compile_ptx(text: str, profile: ISAProfile = TRACK_B_V1) -> LoweredProgram:
    program = parse_ptx(text)
    return Lowerer(program, profile=profile).lower()


def write_binary(lowered: LoweredProgram, output: Path, profile: ISAProfile) -> None:
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_bytes(instructions_to_bytes(lowered.instructions, profile))


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(prog="aec-cc")
    parser.add_argument("input", type=Path)
    parser.add_argument("-o", "--output", required=True, type=Path)
    parser.add_argument("-O", "--opt-level", default="0", choices=["0", "2", "3"])
    parser.add_argument("--profile", choices=sorted(PROFILES), default=TRACK_B_V1.name)
    args = parser.parse_args(argv)

    try:
        profile = PROFILES[args.profile]
        lowered = compile_ptx(args.input.read_text(encoding="utf-8"), profile=profile)
        write_binary(lowered, args.output, profile)
    except (OSError, CompileError) as exc:
        print(f"aec-cc: error: {exc}", file=sys.stderr)
        return 1
    return 0


def _strip_brackets(token: str) -> str:
    token = token.strip()
    if token.startswith("[") and token.endswith("]"):
        return token[1:-1].strip()
    return token


def _is_register(token: str) -> bool:
    return bool(re.match(r"%[A-Za-z]+\d+$", token.strip()))


def _predicate_number(token: str) -> int:
    token = token.strip()
    if token.startswith("%"):
        token = token[1:]
    if not re.fullmatch(r"p\d+", token):
        raise CompileError(f"invalid predicate register: {token}")
    number = int(token[1:])
    if not 0 <= number <= 7:
        raise CompileError(f"predicate register out of range: {token}")
    return number


def _parse_immediate(token: str) -> int:
    token = token.strip()
    if token.startswith("0f"):
        return int(token[2:], 16)
    if token.startswith("0x"):
        return int(token, 16)
    return int(token, 10)


def _conversion_opcode(dest_type: str, src_type: str) -> str:
    dest_is_float = dest_type.startswith("f") or dest_type == "bf16"
    src_is_float = src_type.startswith("f") or src_type == "bf16"
    if dest_is_float and src_is_float:
        return "CVTFF"
    if not dest_is_float and src_is_float:
        return "CVTFI"
    if dest_is_float and not src_is_float:
        return "CVTIF"
    return "CVTII"

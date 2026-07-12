from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "src"
if str(SRC) not in sys.path:
    sys.path.insert(0, str(SRC))

from aec_c1.compiler import compile_ptx
from aec_c1.isa import AECInstruction, encode_instruction, instructions_to_bytes, words_to_msb_hex
from aec_c1.objdump import disassemble


def test_track_b_abi_smoke_encoding_matches_public_hex() -> None:
    instructions = [
        AECInstruction("LOADI", dest=1, imm=40),
        AECInstruction("LOADI", dest=2, imm=2),
        AECInstruction("ADD", dtype="u32", dest=3, src1=1, src2=2),
        AECInstruction("LOADI", dest=4, imm=0x100),
        AECInstruction("ST", dtype="u32", src1=4, src2=3, memory_space="gmem"),
        AECInstruction("HALT"),
    ]
    actual = [words_to_msb_hex(encode_instruction(inst)) for inst in instructions]
    expected = (ROOT.parent.parent / "Track-B/testcases/tests/aec_cases/abi/c0_smoke/program.hex").read_text().splitlines()
    assert actual == expected


def test_objdump_round_trip_smoke() -> None:
    blob = instructions_to_bytes([AECInstruction("LOADI", dest=1, imm=40), AECInstruction("HALT")])
    lines = disassemble(blob)
    assert "LOADI R1, 0x00000028" in lines[0]
    assert lines[1].endswith("HALT")


def test_public_ptx_01_lowers_to_raw_instructions() -> None:
    ptx = (ROOT / "testcases/PTX-01_vector_add.ptx").read_text()
    lowered = compile_ptx(ptx)
    blob = instructions_to_bytes(lowered.instructions)
    assert len(blob) % 16 == 0
    assert lowered.instructions[-1].opcode == "HALT"
    assert lowered.parameter_offsets == {"param_a": 0, "param_b": 8, "param_c": 16, "param_n": 24}


def test_all_public_ptx_files_lower_to_raw_instructions() -> None:
    for ptx_path in sorted((ROOT / "testcases").glob("PTX-*.ptx")):
        lowered = compile_ptx(ptx_path.read_text())
        blob = instructions_to_bytes(lowered.instructions)
        assert len(blob) % 16 == 0, ptx_path.name
        assert lowered.instructions[-1].opcode == "HALT", ptx_path.name

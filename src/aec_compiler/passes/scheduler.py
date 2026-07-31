"""List scheduler with data-dependence graph for AEC instructions.

Operates post-lowering: reorders AEC instructions within basic blocks
to hide load latency while respecting all data and memory dependencies.
"""

from __future__ import annotations

import heapq

from ..analysis import AnalysisManager
from ..ir import IRModule
from ..isa import AECInstruction
from ..legacy_lowering import LoweredProgram
from .base import PassResult


def _schedule_block(insts: list[AECInstruction]) -> list[AECInstruction]:
    """Schedule instructions within a single basic block."""
    n = len(insts)
    if n <= 2:
        return list(insts)

    # Classify each instruction
    kinds = [_inst_kind(i) for i in insts]

    # Priority: LOAD first, then COMPUTE, then STORE, then CONTROL.
    # STORES are NOT reordered relative to each other (memory order).
    def priority(idx: int) -> int:
        k = kinds[idx]
        if k == "LOAD":
            return 0
        if k == "COMPUTE":
            return 1
        if k == "STORE":
            return 2 + idx  # prevent ST reordering
        return 1000 + idx  # CONTROL at end, preserve relative order

    # Build ready set: instructions with all operands satisfied.
    #
    # Dependency model:
    #   RAW  — def → use        (use must wait for definition)
    #   WAR  — use → next-def   (write must wait for all prior reads)
    #   WAW  — def → next-def   (writes to same register stay in order)
    #   STORE→LOAD barrier      (conservative alias safety)
    ready: list[tuple[int, int]] = []  # (priority, index) min-heap
    dep_count: list[int] = []
    dependents: dict[int, list[int]] = {}

    last_store_idx: int | None = None
    # last_def_pos is updated in program order, so it always holds the closest
    # PRECEDING definition of each register — O(1) RAW lookup.  Temp registers
    # like R240-R255 are reused by LOADI; tracking only the closest preceding
    # def per register preserves the same semantics without rescanning def lists.
    last_def_pos: dict[int, int] = {}
    last_write_pos: dict[int, int] = {}  # phys_reg -> last write position (WAW)
    pending_reads: dict[int, list[int]] = {}  # phys_reg -> list of read positions since last write (WAR)

    for idx, inst in enumerate(insts):
        unresolved = 0
        src_regs = tuple(dict.fromkeys(_source_regs(inst)))

        # ---- RAW: each source depends on the closest preceding definition ----
        for s in src_regs:
            closest_def = last_def_pos.get(s, -1)
            if closest_def >= 0:
                unresolved += 1
                dependents.setdefault(closest_def, []).append(idx)

        # ---- WAR: this write must wait for all prior reads since the last
        #     write to the same register (reads that reference the old value) ----
        if _has_dest(inst):
            d = inst.dest
            for read_pos in pending_reads.get(d, []):
                unresolved += 1
                dependents.setdefault(read_pos, []).append(idx)
            pending_reads[d] = []  # reads before this write are now accounted for

        # ---- WAW: writes to the same register must stay in program order ----
        if _has_dest(inst):
            d = inst.dest
            if d in last_write_pos:
                unresolved += 1
                dependents.setdefault(last_write_pos[d], []).append(idx)
            last_write_pos[d] = idx

        # ---- Track reads of source registers (for WAR edges from later writes) ----
        for s in src_regs:
            pending_reads.setdefault(s, []).append(idx)

        # ---- STORE→LOAD barrier (conservative alias safety) ----
        if kinds[idx] == "LOAD" and last_store_idx is not None:
            unresolved += 1
            dependents.setdefault(last_store_idx, []).append(idx)
        if kinds[idx] == "STORE":
            last_store_idx = idx

        dep_count.append(unresolved)
        if unresolved == 0:
            heapq.heappush(ready, (priority(idx), idx))

        if _has_dest(inst):
            last_def_pos[inst.dest] = idx

    scheduled: list[int] = []
    while ready:
        # Pop the highest-priority ready instruction (min-heap, (priority, index)).
        _, best = heapq.heappop(ready)
        scheduled.append(best)
        # Update dependents
        for dep in dependents.get(best, []):
            dep_count[dep] -= 1
            if dep_count[dep] == 0:
                heapq.heappush(ready, (priority(dep), dep))

    if len(scheduled) != n:
        raise ValueError("scheduler dependency graph did not resolve")

    return [insts[i] for i in scheduled]


def _inst_kind(inst: AECInstruction) -> str:
    op = inst.opcode.upper()
    if op in {"BR", "BRX", "HALT", "CALL", "RET"}:
        return "CONTROL"
    if op == "ST":
        return "STORE"
    if op == "LD":
        return "LOAD"
    return "COMPUTE"


def _has_dest(inst: AECInstruction) -> bool:
    return inst.opcode.upper() not in {"ST", "BR", "BRX", "HALT", "CALL", "RET"}


def _source_regs(inst: AECInstruction) -> list[int]:
    regs: list[int] = []
    for val in (inst.src1, inst.src2, inst.src3):
        if isinstance(val, int) and 0 <= val <= 255:
            regs.append(val)
    return regs


def schedule_lowered(lowered: LoweredProgram, module: IRModule) -> LoweredProgram:
    """Post-lowering entry point: schedule AEC instructions within basic blocks."""

    instructions = list(lowered.instructions)
    if len(instructions) <= 2:
        return lowered

    # Find basic block boundaries from branch targets and labels
    leaders: set[int] = {0}
    for i, inst in enumerate(instructions):
        if inst.opcode.upper() in {"BR", "BRX"}:
            target = inst.imm
            if 0 <= target < len(instructions):
                leaders.add(target)
            if i + 1 < len(instructions):
                leaders.add(i + 1)
        elif inst.opcode.upper() == "HALT":
            if i + 1 < len(instructions):
                leaders.add(i + 1)

    sorted_leaders = sorted(leaders)
    for li in range(len(sorted_leaders)):
        start = sorted_leaders[li]
        end = sorted_leaders[li + 1] if li + 1 < len(sorted_leaders) else len(instructions)
        block = instructions[start:end]
        if len(block) <= 2:
            continue
        scheduled = _schedule_block(block)
        for j, inst in enumerate(scheduled):
            instructions[start + j] = inst

    return LoweredProgram(
        instructions=instructions,
        parameter_offsets=lowered.parameter_offsets,
    )

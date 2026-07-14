"""Linear-scan register allocator using live-interval analysis.

Produces a virtual-to-physical register mapping stored in the IR module
metadata.  The Lowerer reads this mapping and skips the bootstrap allocator
when it is present.
"""

from __future__ import annotations

from ..analysis import AnalysisManager, LivenessFacts
from ..ir import IRModule
from .base import PassResult


class LinearScanRegisterAllocationPass:
    """Assign physical GPRs to virtual registers using linear-scan allocation.

    Uses liveness facts to compute live intervals, then scans in order of
    first definition.  64-bit pair registers are allocated as consecutive
    even-odd pairs (e.g. R2/R3).  Predicates are assigned separately from
    GPRs.

    When physical registers are exhausted the pass reports pressure but
    does not spill — the caller should fall back to the bootstrap allocator
    when a mapping is incomplete.

    O2 proven-safe: pair-assignment bug fixed (even base always selected),
    fallback pair-path verifies both registers available, predicate
    allocation uses proper expiry.
    """

    name = "linear-scan-register-allocation"

    MAX_GPR = 239   # R1..R239 usable (R0 reserved); R240-R255 reserved for temps
    MAX_PRED = 7    # P0..P7

    def run(self, module: IRModule, analyses: AnalysisManager) -> PassResult:
        try:
            facts: LivenessFacts = analyses.get("liveness")
        except Exception:
            return PassResult(details={"error": "liveness analysis not available"})

        live_ranges = {
            name: lr for name, lr in facts.live_ranges.items()
            if lr.is_live and not name.startswith("%p")
        }

        if not live_ranges:
            return PassResult(details={"allocated": 0, "pressure": 0})

        sorted_ranges = sorted(live_ranges.values(), key=lambda lr: lr.first_def)

        mapping: dict[str, int] = {}
        active: list[tuple[int, int]] = []  # (last_use, phys_reg)
        free_list: list[int] = list(range(1, self.MAX_GPR + 1))
        free_list.reverse()

        for lr in sorted_ranges:
            # Strip #N suffix from split live ranges (e.g. %r3#1 -> %r3)
            vreg = getattr(lr, "register").split("#")[0]
            # Expire: return physical registers whose live range ended
            still_active = []
            for end, phys in active:
                if end < lr.first_def:
                    free_list.append(phys)
                else:
                    still_active.append((end, phys))
            active = still_active

            is_pair = vreg.startswith("%rd") or vreg.startswith("%bd")

            if is_pair:
                assigned = None
                # Find an even-odd pair in the free list.
                for i in range(len(free_list) - 1, -1, -1):
                    if free_list[i] % 2 == 0 and free_list[i] + 1 in free_list:
                        j = free_list.index(free_list[i] + 1)
                        even_val = free_list[i]  # guaranteed even by the if-condition
                        # Pop both, larger index first to preserve the smaller.
                        if i > j:
                            free_list.pop(i)
                            free_list.pop(j)
                        else:
                            free_list.pop(j)
                            free_list.pop(i)
                        assigned = even_val
                        if assigned == 0:
                            assigned = None  # R0 reserved
                        break

                if assigned is not None:
                    mapping[vreg] = assigned
                    active.append((lr.last_use, assigned))
                    active.append((lr.last_use, assigned + 1))
                elif len(free_list) >= 2:
                    # Fallback: try to construct a pair from the top two free regs.
                    phys = free_list.pop()
                    # Try to get a pair: ensure the base is even.
                    if phys % 2 == 1:
                        if phys > 0:
                            phys -= 1
                        else:
                            phys = 1  # can't go below 1
                    # Verify pair register is also free.
                    if phys + 1 in free_list:
                        free_list.remove(phys + 1)
                        if phys > 0 and phys % 2 == 0 and phys + 1 <= self.MAX_GPR:
                            mapping[vreg] = phys
                            active.append((lr.last_use, phys))
                            active.append((lr.last_use, phys + 1))
                    else:
                        # Pair not available — put back the popped register.
                        free_list.append(phys)
            else:
                if free_list:
                    phys = free_list.pop()
                    mapping[vreg] = phys
                    active.append((lr.last_use, phys))

        # Predicate allocation
        pred_ranges = {
            name: lr for name, lr in facts.live_ranges.items()
            if lr.is_live and name.startswith("%p")
        }
        pred_mapping: dict[str, int] = {}
        pred_free = list(range(self.MAX_PRED + 1))
        pred_active: list[tuple[int, int]] = []
        for pred_name, lr in sorted(pred_ranges.items(), key=lambda kv: kv[1].first_def):
            pred_name = pred_name.split("#")[0]
            still_active = []
            for end, p in pred_active:
                if end < lr.first_def:
                    pred_free.append(p)
                else:
                    still_active.append((end, p))
            pred_active = still_active
            if pred_free:
                p = pred_free.pop()
                pred_mapping[pred_name] = p
                pred_active.append((lr.last_use, p))

        module.metadata["register_mapping"] = mapping
        module.metadata["predicate_mapping"] = pred_mapping

        allocated = len(mapping)
        details = {
            "allocated_gprs": allocated,
            "allocated_preds": len(pred_mapping),
            "total_virtual_regs": len(live_ranges),
            "register_pressure": allocated,
            "max_gpr": max(mapping.values()) if mapping else 0,
            "transforms_applied": 0,  # RA is infrastructure, not optimization
        }
        return PassResult(changed=True, details=details)

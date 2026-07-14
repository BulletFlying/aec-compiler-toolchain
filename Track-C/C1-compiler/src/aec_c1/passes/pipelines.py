"""Named pass pipelines selected by the public optimization level.

O2 is scoring-critical: only passes with proven correctness (unit, negative,
and manifest e2e coverage) are enabled. O3 enables experimental passes that
may improve performance but carry higher miscompile risk.
"""

from __future__ import annotations

from .foundation import (
    MaterializeCFGPass,
    RecordLoopAnalysisPass,
    RecordUniformityPass,
    ValidateProgramPass,
)
from .manager import PassManager
from .register_allocation import LinearScanRegisterAllocationPass
from .gemm import LoopUnrollingPass
from .memory import LoadHoistingPass
from .scalar import (
    BasicBlockLocalCSEPass,
    BlockSimplificationPass,
    ConservativeDeadResultEliminationPass,
    GlobalConstantPropagationPass,
    GlobalDeadCodeEliminationPass,
    LocalConstantFoldingPass,
    LoopInvariantCodeMotionPass,
    RepeatedGlobalLoadReusePass,
)


def build_pipeline(opt_level: str) -> PassManager:
    if opt_level == "0":
        return PassManager(
            "O0-foundation",
            [ValidateProgramPass(), MaterializeCFGPass()],
        )
    if opt_level == "2":
        # Scoring-critical: only passes with proven safety and correctness evidence.
        # O2 pipeline (M2-M3 complete; M4-M5 in O3 — see O3 pipeline below):
        #   Validate → DRE → CSE → LocalCF → GlobalCP → LoadReuse
        #   → CFG → Uniformity → GlobalDCE → LoopAnalysis → LICM
        #   → CFG → Uniformity → BlockSimp → CFG → LoadHoisting(M3)
        #   → CFG → Uniformity
        #   (LinearScanRA M4, Scheduler M4, LoopUnrolling M5 are O3-only)
        return PassManager(
            "O2-conservative-scalar",
            [
                ValidateProgramPass(),
                ConservativeDeadResultEliminationPass(),
                BasicBlockLocalCSEPass(),
                LocalConstantFoldingPass(),
                GlobalConstantPropagationPass(),
                RepeatedGlobalLoadReusePass(),
                MaterializeCFGPass(),
                RecordUniformityPass(),
                GlobalDeadCodeEliminationPass(),
                RecordLoopAnalysisPass(),
                LoopInvariantCodeMotionPass(),
                MaterializeCFGPass(),
                RecordUniformityPass(),
                BlockSimplificationPass(),
                MaterializeCFGPass(),
                RecordUniformityPass(),
                LoadHoistingPass(),
                MaterializeCFGPass(),
                RecordUniformityPass(),
            ],
        )
    if opt_level == "3":
        # Experimental: adds LICM, global CP, load reuse, and block simplification
        # on top of the O2 baseline. These passes have known limitations and are
        # NOT proven safe for scoring-critical use.
        return PassManager(
            "O3-experimental",
            [
                ValidateProgramPass(),
                ConservativeDeadResultEliminationPass(),
                BasicBlockLocalCSEPass(),
                LocalConstantFoldingPass(),
                RepeatedGlobalLoadReusePass(),
                MaterializeCFGPass(),
                RecordUniformityPass(),
                GlobalConstantPropagationPass(),
                GlobalDeadCodeEliminationPass(),
                MaterializeCFGPass(),
                RecordUniformityPass(),
                RecordLoopAnalysisPass(),
                BlockSimplificationPass(),
                LoopInvariantCodeMotionPass(),
                LoadHoistingPass(),
                LinearScanRegisterAllocationPass(),
                LoopUnrollingPass(),
                MaterializeCFGPass(),
                RecordUniformityPass(),
            ],
        )
    raise ValueError(f"unsupported optimization level: O{opt_level}")

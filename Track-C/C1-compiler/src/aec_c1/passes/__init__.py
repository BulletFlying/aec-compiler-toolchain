"""Explicit compiler pass framework."""

from .base import CompilerPass, PassResult
from .manager import PassManager, PassRecord
from .pipelines import build_pipeline
from .scalar import ConservativeDeadResultEliminationPass

__all__ = [
    "CompilerPass",
    "ConservativeDeadResultEliminationPass",
    "PassManager",
    "PassRecord",
    "PassResult",
    "build_pipeline",
]

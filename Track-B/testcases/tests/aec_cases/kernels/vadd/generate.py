#!/usr/bin/env python3
"""Generate independent expected bytes for K-VADD."""

from __future__ import annotations

import struct
from pathlib import Path


def main() -> int:
    inputs = Path("input")
    expected = Path("expected")
    inputs.mkdir(exist_ok=True)
    expected.mkdir(exist_ok=True)
    lhs = [lane * 3 + 1 for lane in range(32)]
    rhs = [1000 - lane * 7 for lane in range(32)]
    inputs.joinpath("gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", v) for v in lhs))
    inputs.joinpath("gmem_00000200.bin").write_bytes(b"".join(struct.pack("<I", v) for v in rhs))
    expected.joinpath("gmem_00000300.bin").write_bytes(
        b"".join(struct.pack("<I", (a + b) & 0xFFFFFFFF) for a, b in zip(lhs, rhs))
    )
    return 0

if __name__ == "__main__":
    raise SystemExit(main())

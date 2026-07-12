#!/usr/bin/env python3
"""Generate independent expected bytes for K-GEMM-NAIVE."""

from __future__ import annotations

import struct
from pathlib import Path


def main() -> int:
    inputs = Path("input")
    expected = Path("expected")
    inputs.mkdir(exist_ok=True)
    expected.mkdir(exist_ok=True)
    a = [1, 2, 3, 4]
    b = [5, 6, 7, 8]
    c = [
        a[row * 2] * b[column] + a[row * 2 + 1] * b[2 + column]
        for row in range(2)
        for column in range(2)
    ]
    inputs.joinpath("gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", v) for v in a))
    inputs.joinpath("gmem_00000200.bin").write_bytes(b"".join(struct.pack("<I", v) for v in b))
    expected.joinpath("gmem_00000300.bin").write_bytes(b"".join(struct.pack("<I", v) for v in c))
    return 0

if __name__ == "__main__":
    raise SystemExit(main())

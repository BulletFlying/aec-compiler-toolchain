#!/usr/bin/env python3
"""Generate independent expected bytes for K-HISTOGRAM."""

from __future__ import annotations

import struct
from pathlib import Path


def main() -> int:
    inputs = Path("input")
    expected = Path("expected")
    inputs.mkdir(exist_ok=True)
    expected.mkdir(exist_ok=True)
    inputs.joinpath("gmem_00000100.bin").write_bytes(bytes(128))
    bins = [8, 8, 8, 8] + [0] * 28
    expected.joinpath("gmem_00000100.bin").write_bytes(
        b"".join(struct.pack("<I", value) for value in bins)
    )
    return 0

if __name__ == "__main__":
    raise SystemExit(main())

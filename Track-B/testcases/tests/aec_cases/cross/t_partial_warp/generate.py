#!/usr/bin/env python3
"""Generate independent expected bytes for T-PARTIAL-WARP."""

from __future__ import annotations

import struct
from pathlib import Path


def main() -> int:
    target = Path("expected")
    target.mkdir(exist_ok=True)
    values = list(range(33))
    if "T-PARTIAL-WARP" == "T-REG-ALIAS": values = [18] * 33
    if "T-PARTIAL-WARP" == "T-FP-POLICY": values = [0] * 33
    if "T-PARTIAL-WARP" == "K-FILL": values = [0xA5A5A5A5] * 33
    target.joinpath("gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", v) for v in values))
    return 0

if __name__ == "__main__":
    raise SystemExit(main())


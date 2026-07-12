#!/usr/bin/env python3
"""Generate ABI.C0.SMOKE expected bytes."""

from __future__ import annotations

import struct
from pathlib import Path


def main() -> int:
    expected = Path("expected")
    expected.mkdir(exist_ok=True)
    payload = struct.pack("<I", 42) + bytes(12)
    (expected / "gmem_00000100.bin").write_bytes(payload)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())


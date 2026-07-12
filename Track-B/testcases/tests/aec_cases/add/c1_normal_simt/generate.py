#!/usr/bin/env python3
"""Generate ADD.C1.NORMAL.SIMT expected bytes."""

from __future__ import annotations

import struct
from pathlib import Path


def main() -> int:
    expected = Path("expected")
    expected.mkdir(exist_ok=True)
    values = [4 * lane + 10 for lane in range(32)]
    (expected / "gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", value) for value in values))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())


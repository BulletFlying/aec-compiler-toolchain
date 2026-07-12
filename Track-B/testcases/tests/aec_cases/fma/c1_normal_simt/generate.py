#!/usr/bin/env python3
"""Generate independent expected bytes for FMA.C1.NORMAL.SIMT."""
import struct
from pathlib import Path

expected = Path("expected")
expected.mkdir(exist_ok=True)
(expected / "gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", 0x40600000) for _ in range(32)))


#!/usr/bin/env python3
"""Generate independent expected bytes for BFX.C1.NORMAL.SIMT."""
import struct
from pathlib import Path

expected = Path("expected")
expected.mkdir(exist_ok=True)
values = [((0x123456f0 >> 4) & 0xff) for lane in range(32)]
(expected / "gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", value) for value in values))

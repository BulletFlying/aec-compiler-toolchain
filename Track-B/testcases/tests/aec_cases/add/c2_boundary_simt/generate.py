#!/usr/bin/env python3
"""Generate independent expected bytes for ADD.C2.BOUNDARY.SIMT."""
import struct
from pathlib import Path

expected = Path("expected")
expected.mkdir(exist_ok=True)
values = [((lane + 0xfffffff0) & 0xffffffff) for lane in range(32)]
(expected / "gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", value) for value in values))

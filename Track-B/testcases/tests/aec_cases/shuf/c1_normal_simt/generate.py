#!/usr/bin/env python3
import struct
from pathlib import Path
values = [0]*32
Path("expected").mkdir(exist_ok=True)
Path("expected/gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", x & 0xffffffff) for x in values))

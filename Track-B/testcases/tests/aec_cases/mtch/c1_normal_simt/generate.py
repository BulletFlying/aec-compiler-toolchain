#!/usr/bin/env python3
import struct
from pathlib import Path
values = [sum(1 << j for j in range(32) if (j & 3) == (i & 3)) for i in range(32)]
Path("expected").mkdir(exist_ok=True)
Path("expected/gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", x & 0xffffffff) for x in values))

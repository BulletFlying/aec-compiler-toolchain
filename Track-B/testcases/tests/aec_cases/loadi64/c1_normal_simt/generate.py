#!/usr/bin/env python3
import struct
from pathlib import Path
Path("expected").mkdir(exist_ok=True)
Path("expected/gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", 0x55667788) for _ in range(32))+b"".join(struct.pack("<I", 0x11223344) for _ in range(32)))


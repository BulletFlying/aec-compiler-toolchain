#!/usr/bin/env python3
import math
import struct
from pathlib import Path
values=[math.sqrt(float(i+1)) for i in range(32)]
Path("expected").mkdir(exist_ok=True)
Path("expected/gmem_00000100.bin").write_bytes(b"".join(struct.pack("<f", x) for x in values))


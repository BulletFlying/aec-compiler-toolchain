#!/usr/bin/env python3
"""Generate LDC.C1 constant-memory bytes."""
import struct
from pathlib import Path
def main():
    Path("input").mkdir(exist_ok=True); Path("expected").mkdir(exist_ok=True)
    data = b"".join(struct.pack("<I", 0x60000000 + 9*i) for i in range(32))
    Path("input/cmem_00000000.bin").write_bytes(data); Path("expected/gmem_00000100.bin").write_bytes(data)
if __name__ == "__main__": main()

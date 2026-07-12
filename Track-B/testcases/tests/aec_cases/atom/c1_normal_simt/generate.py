#!/usr/bin/env python3
"""Generate distinct-address ATOM.ADD initial and old-value bytes."""
import struct
from pathlib import Path
def main():
    Path("input").mkdir(exist_ok=True); Path("expected").mkdir(exist_ok=True)
    data = b"".join(struct.pack("<I", 100 + i) for i in range(32))
    Path("input/gmem_00000000.bin").write_bytes(data); Path("expected/gmem_00000100.bin").write_bytes(data)
if __name__ == "__main__": main()

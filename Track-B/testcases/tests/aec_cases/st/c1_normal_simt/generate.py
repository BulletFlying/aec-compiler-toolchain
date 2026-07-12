#!/usr/bin/env python3
"""Generate ST.C1's per-lane store oracle."""
import struct
from pathlib import Path
def main():
    Path("expected").mkdir(exist_ok=True)
    Path("expected/gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", 0x1200 + i) for i in range(32)))
if __name__ == "__main__": main()

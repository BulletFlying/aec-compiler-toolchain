#!/usr/bin/env python3
"""Generate independent per-lane input and expected bytes for LD.C1."""
import struct
from pathlib import Path

def main():
    Path("input").mkdir(exist_ok=True); Path("expected").mkdir(exist_ok=True)
    values = [0x10000000 + 17 * lane for lane in range(32)]
    data = b"".join(struct.pack("<I", value) for value in values)
    Path("input/gmem_00000000.bin").write_bytes(data)
    Path("expected/gmem_00000100.bin").write_bytes(data)
if __name__ == "__main__": main()

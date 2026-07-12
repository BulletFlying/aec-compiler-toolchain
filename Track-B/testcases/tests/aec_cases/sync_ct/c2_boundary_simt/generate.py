#!/usr/bin/env python3
import struct
from pathlib import Path
def main():
 Path("expected").mkdir(exist_ok=True); Path("expected/gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I",0x80+i) for i in range(64)))
if __name__ == "__main__": main()

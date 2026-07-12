#!/usr/bin/env python3
import struct
from pathlib import Path
def main():
 Path("expected").mkdir(exist_ok=True); Path("expected/gmem_00000200.bin").write_bytes(b"".join(struct.pack("<I",0x200+i) for i in range(32)))
if __name__ == "__main__": main()

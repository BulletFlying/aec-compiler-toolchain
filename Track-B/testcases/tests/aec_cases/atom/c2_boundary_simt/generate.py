#!/usr/bin/env python3
"""Generate ATOM.C2 CAS values; odd lanes retain zero destination state."""
import struct
from pathlib import Path
def main():
    Path("input").mkdir(exist_ok=True); Path("expected").mkdir(exist_ok=True)
    initial = [0xaaaa0000 if i % 2 == 0 else 0x11110000 + i for i in range(32)]
    Path("input/gmem_00000000.bin").write_bytes(b"".join(struct.pack("<I", x) for x in initial))
    old_values = [value if lane % 2 == 0 else 0 for lane, value in enumerate(initial)]
    Path("expected/gmem_00000100.bin").write_bytes(b"".join(struct.pack("<I", x) for x in old_values))
if __name__ == "__main__": main()

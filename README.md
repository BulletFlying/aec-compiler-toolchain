# C1 AEC Compiler Workspace

This repository is an independent workspace for the C1 AEC compiler effort.
It is intentionally scoped to the copied C1 materials and the local compiler
implementation under `Track-C/C1-compiler`.

The repository is not a fork of the contest public repository and should not
use that repository as a Git remote. Public contest specification text and
testcase files retained here remain copied reference material.

## Layout

```text
Track-C/C1-compiler/
  compiler/aec-cc
  disassembler/aec-objdump
  agent/run_agent
  src/aec_c1/
  testcases/
  tests/
  spec.md
  scoring.md
```

## Quick Check

Run from `Track-C/C1-compiler`:

```powershell
C:\Users\HP\anaconda3\envs\zhang\python.exe -m pytest tests
```

## License

See `LICENSE`.

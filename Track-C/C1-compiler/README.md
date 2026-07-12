# C1 Compiler Workspace

This directory now contains the initial C1 implementation workspace.

## Entry Points

- `compiler/aec-cc`: PTX-style IR to AEC binary.
- `disassembler/aec-objdump`: raw AEC binary disassembler.
- `agent/run_agent`: conservative offline optimization-agent stub.

Run them from this directory:

```bash
python compiler/aec-cc testcases/PTX-01_vector_add.ptx -O0 -o build/PTX-01.aecbin
python disassembler/aec-objdump build/PTX-01.aecbin
python agent/run_agent
```

## Current Scope

The checked-in compiler is a bootstrap O0 pipeline, not a complete contest
solution.  It provides:

- Track-B Appendix A raw 128-bit instruction encoding.
- A separated `c2_b3_v2` ISA profile boundary for the C2 tensor encoding.
- PTX parsing for the public C1 syntax shape.
- Basic lowering for parameter loads, special-register moves, integer/FP32
  arithmetic, predicates, branches, global loads/stores, f16-to-f32 conversion,
  and aligned u16 load expansion.
- Structured forward early-exit if-conversion for straight-line regions, used
  to avoid non-uniform boundary `BRX` in PTX-01-style kernels.
- A CFG model with basic blocks, predecessor/successor edges,
  reverse-postorder traversal, dominators, backedge detection, and natural-loop
  records.
- A conservative uniformity lattice (`UNKNOWN`, `UNIFORM`, `VARYING`) used to
  prove PTX-02's fixed-count loop backedge is uniform while if-converting its
  varying boundary exit.
- Raw binary output using `w0,w1,w2,w3` little-endian `uint32_t` order.
- Disassembly for generated raw binaries and C2-style images with a 64-byte
  `AECI` header.
- A small Track-B semantic simulator for PTX-01 and PTX-02 executable
  differential tests, including BRX uniformity checks and branch traces.
- PTX-02 bit-exact local differential coverage for boundary sizes and 100
  randomized cases, with invalid-lane global-memory side-effect checks.

Known gaps:

- PTX-02 is correctness-validated locally, but its advertised optimization
  passes are not implemented: no CSE, DCE, LICM, basic-block merge, or
  performance scheduling is active yet.
- PTX-03, PTX-04, and PTX-05 have not been executable-validated. PTX-05 still
  contains legacy varying-branch lowering in cases where multiple overlapping
  data guards would need predicate composition.
- No C1 official binary container format is specified yet, so `aec-cc` defaults
  to Track-B raw binary.
- Optimization passes, register-pressure handling, spill code, scheduling, and
  tensor GEMM lowering are not implemented.
- There is no public C1 Golden Model or Cycle Model in this repository, so the
  current verification is local semantic simulation plus static encoding and
  CLI smoke testing.

## Verification

Use the requested Anaconda interpreter on this machine:

```powershell
C:\Users\HP\anaconda3\envs\zhang\python.exe -m pytest tests
```

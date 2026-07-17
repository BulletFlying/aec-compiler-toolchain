# Implementation Status

This file is the mutable implementation ledger for the AEC Compiler Toolchain.

Last updated: 2026-07-17

## Current State

**Version:** 0.2.0
**Repository:** `BulletFlying/aec-compiler-toolchain`

### Compiler Capabilities

- Raw 128-bit AEC instruction encoding (little-endian `uint32_t` word order)
- PTX 9.3 restricted scalar subset parsing
- Parameter loading through `.pmem` offsets (PMEM ABI)
- Special register reads (`%tid`, `%ntid`, `%ctaid`, `%nctaid`, `%laneid`)
- Integer, bitwise, shift, and FP32 scalar operations
- Global memory loads/stores with predicate comparisons and branches
- `ret` → `HALT` lowering, `shl.b32` → `SHL.u32` encoding

### Optimization Pipeline (O2 default)

| Pass | Status |
|---|---|
| Dead Result Elimination | Complete, tested |
| BB-local CSE | Complete, tested |
| Local Constant Folding | Complete, tested |
| Global Constant Propagation | Complete, tested |
| Repeated Global Load Reuse | Complete, tested |
| Global DCE | Complete, tested |
| LICM | Complete, tested |
| Block Simplification | Complete, tested |
| Load Hoisting | Complete, tested |
| Loop Unrolling (GEMM) | Complete, tested |
| Linear-Scan RA (loop-aware) | Complete, tested |
| DDG List Scheduler | Complete, tested |

### Test Coverage

- 173 unit/integration tests (fast)
- 5 e2e manifest tests (slow)
- Architecture guardrail tests
- CModel integration harness (requires Linux x86_64)

## Known Limitations

- Windows platform lacks `aec-precise` CModel binary (Linux/macOS only)
- No spill/reload support for extreme register pressure
- No shared memory optimization
- Extended ISA profile (`track_b_v1`) is for compatibility only

## Verification Commands

```bash
python -m compileall -q src compiler disassembler tests
python -m pytest -q tests                              # Fast tests
python -m pytest -q tests/test_manifest_execution.py -m slow -v  # E2E tests
```

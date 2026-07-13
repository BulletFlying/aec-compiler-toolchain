# C1 Compiler Status

This file is the mutable implementation ledger for `Track-C/C1-compiler/`. Long-term goals and scoring constraints live in `C1_PROJECT_CHARTER.md`; operating rules live in `../AGENTS.md` and `DEVELOPMENT_POLICY.md`.

## Snapshot

Status date: 2026-07-13

Writable repository: `BulletFlying/agentic4systems-c1-compiler-bootstrap`

Local Git remote policy: only `origin` pointing to `BulletFlying/agentic4systems-c1-compiler-bootstrap`

Official repository remote: not configured

C1 code milestone baseline: `31f9171e05c5f0b298f616b0d313512931df1882`

Governance/CI baseline before repository detachment: `7cb1f5bdad08a5d660d168a20312013823a19216`

Repository detachment: the working tree has been reduced to C1-relevant files and will be recommitted with independent root history.

## Milestone state

| Milestone | State | Evidence boundary |
|---|---|---|
| M0 ISA/CLI/encoder baseline | Locally complete | Track-B raw encoder, decoder, objdump and official smoke hex cross-check exist |
| M1 PTX-01 correctness loop | Locally complete | Partial-warp and randomized differential tests; invalid lanes produce no GMEM effects |
| M2.1 PTX-02 CFG/uniform-loop correctness | Locally complete | CFG, dominators, backedges, natural loops, three-state uniformity, one proven-uniform loop BRX and executable differential tests exist |
| M2.2 scalar optimization | Not started | No real constant propagation, CSE, DCE, LICM or block merge pipeline |
| M3 PTX-03 memory optimization | Not started | No executable semantic validation or memory optimization pass |
| M4 PTX-04 regalloc/scheduling | Not started | Bootstrap allocation only; no liveness, spill, DDG or list scheduling |
| M5 PTX-05 GEMM | Not started | No validated scalar/tensor GEMM lowering or multi-precision pipeline |
| M6 Agent/final packaging | Stub only | Agent returns a static conservative configuration; no report-driven closed loop |

`Locally complete` does not mean official Golden Model, Cycle Model or official grader approval.

## Verification ledger

Confirmed in repository content:

- PTX-01 executable simulator tests cover fixed boundary sizes and 100 random cases.
- PTX-02 tests cover CFG structure, branch uniformity classification, fixed boundary sizes, 100 random cases, bit-exact staged FP32 rounding and invalid-lane GMEM side effects.
- The generated PTX-02 program is structurally expected to contain one backward `BRX` and end in `HALT`.
- GitHub Actions configuration exists for Python 3.10/3.13, `compileall`, pytest, CLI/objdump smoke and repository hygiene.

Not independently executed by the GitHub connector in this status update:

- Local Windows pytest run.
- Official C1 Golden Model or Cycle Model.
- Official binary validator.
- GitHub Actions run for the current workflow; no completed run was observed before this governance update.

## Current architecture

Implemented modules:

- `ptx.py`: structural PTX parser.
- `cfg.py`: blocks, edges, traversal, dominators, backedges and natural loops.
- `analysis.py`: conservative linear three-state uniformity and basic def/use records.
- `compiler.py`: lowering, control plan, branch legalization, bootstrap allocation and CLI.
- `isa.py`: separated Track-B and C2/B3 profiles, encoder/decoder and disassembly helpers.
- `sim.py`: local Track-B subset simulator and branch/memory traces.

## Technical-debt register

### High priority

1. `legacy_varying_branch_items` permits a proven-varying branch to reach direct `BRX` when forward-exit legalization fails. This is a temporary compatibility escape hatch, not a safe general solution. It must not survive into a correctness claim for PTX-03/04/05.
2. Uniformity is currently evaluated in source order rather than as a CFG fixed-point dataflow analysis. It is not robust to arbitrary block reorder, joins, loop-carried definitions or future phi nodes.
3. `compiler.py` owns analysis orchestration, control legalization, lowering, bootstrap allocation, branch patching, output and CLI. New optimization modules must not be added by further expanding this monolith.

### Medium priority

1. Temporary registers R240-R255 are reset per PTX instruction. This is safe only while all generated temporaries are instruction-local; future multi-instruction expansions must document lifetime or move to a real virtual-register IR.
2. PTX 64-bit pointer operations are represented through paired registers while only low 32-bit AEC address offsets are semantically used. Address legalization needs an explicit IR contract.
3. `-O0`, `-O2` and `-O3` are accepted but do not yet select real pass pipelines.
4. The local simulator covers only a subset and must not share transform logic with the compiler or be treated as the official oracle.

## Organizer clarification

Still unresolved from public materials:

- Exact C1 `.aecbin` Header/Code/Data/Relocation/Symbol Table layout.
- Formal PMEM kernel-parameter ABI.
- Whether C1 T5 uses Track-B scalar ISA, C2/B3 tensor extensions, or another frozen profile.
- Availability and interface of the official C1 validator, Golden Model, Cycle Model and scoring script.

## Next single main task

M2.2 architecture and scalar-pass foundation:

1. Introduce an explicit pass pipeline and analysis invalidation contract.
2. Upgrade uniformity to CFG worklist/fixed-point analysis before relying on block reordering.
3. Remove or tightly quarantine unsafe legacy varying-branch fallback.
4. Implement constant propagation/folding, DCE and basic-block simplification with unit, mutation and executable differential tests.
5. Keep PTX-03/04/05 out of scope until the M2.2 correctness gate passes.

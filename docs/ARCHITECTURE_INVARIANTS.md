# Compiler Architecture Invariants

This document defines structural rules for the compiler framework. The goal is to prevent incremental feature work from turning the compiler into a monolithic implementation.

## Layer ownership

### Analysis

Analysis modules compute reusable facts only.

Allowed:
```text
IR → AnalysisResult / Facts
```

Forbidden:
```text
Analysis → mutate IR
Analysis → emit ISA
Analysis → depend on compiler pipeline state
```

Examples: CFG construction, uniformity analysis, liveness, and memory facts.

## Pass framework

Compiler transformations must be represented as passes.

Required interface:
```text
Pass.run(IR, AnalysisManager) → PassResult
```

A pass must declare analysis invalidation explicitly.

Forbidden:
- hidden global compiler state
- modifying unrelated compiler phases directly
- adding optimization behavior into CLI handling

## Backend isolation

Backend code converts validated compiler representations into target instructions.

Forbidden:
```text
if kernel == <specific name>
if filename == <specific file>
if register == <special case>
```

Target behavior must be represented by ISA profiles and normal compiler rules. The `shl.b32 → SHL.u32` encoding rule is a general opcode/type rule applied uniformly.

## Branch semantics

`BRX` may be emitted only for branches proven uniform. Unknown uniformity is not uniform. If a branch is not provably uniform, the compiler should reject it or legalize it by a general transformation such as if-conversion.

## Simulator role

The simulator is a local semantic checker for bootstrap and differential testing. It is not a replacement for external validation models.

## Regression requirement

Architecture changes must preserve:
- Basic lowering correctness
- Control-flow correctness
- Public test suite compile smoke
- O0 compatibility with the established lowering path unless intentionally changed with evidence

## Review requirement

New optimization functionality should first introduce:
1. IR representation if required
2. pass abstraction
3. analysis dependency
4. regression tests

Only then should the optimization implementation be added.

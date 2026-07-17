# Performance Model Guidance

This document records performance-model guidance for the AEC Compiler Toolchain.

## Architecture reference

The compiler targets an abstract AEC instruction set. The following storage hierarchy was used as a reference during development:

| Level | Reference Latency |
|---|---|
| Register | ~1 cycle |
| Shared Memory | ~20 cycles |
| L1 Cache | ~40 cycles |
| L2 Cache | ~200 cycles |
| HBM | ~600 cycles |
| Host memory (PCIe) | ~5 µs |

## Performance Model Dimensions

The local performance model should track static metrics observable from compilation reports:

| Dimension | Purpose |
|---|---|
| Instruction count | Machine instruction count from compilation report |
| Register count | Physical register usage |
| Predicate count | Predicate register usage |
| Spill count | Load/store spill operations |
| Branch count | Static branch instruction count |
| Load/store count | Memory operation breakdown |
| Memory instruction ratio | Fraction of memory vs compute instructions |
| Estimated dependency depth | Static estimate from scheduler |

## CModel Integration

The `aec-precise` reference model (provided in `aec-cmodel/bin/`) reports dynamic execution step counts. When runnable (Linux x86_64 or macOS arm64), use this as the closest available dynamic performance observation.

## Optimization Guidance

- Improve global memory access coalescing
- Use shared memory to cache reusable data (avoid bank conflicts)
- Control register pressure to reduce spills
- Select appropriate loop unrolling factors for GEMM patterns
- Prefer FMA over separate multiply-add for FP32 operations

## Limitations

The performance model is intentionally simple and static. It does not attempt cycle-accurate simulation. The tool does not depend on CUDA, GPU hardware, or vendor-specific profiling tools.

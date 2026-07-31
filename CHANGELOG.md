# Changelog

All notable changes to the AEC Compiler Toolchain.

## [0.2.1] — 2026-07-31

### Changed
- Report `performance_target` values renamed from `track_c_hint_platform_*` to `aec_hint_platform_*` (removes contest-track naming; CLI `--performance-target` and report JSON updated in lockstep)
- CI workflow renamed `c1-tests.yml` → `tests.yml`; issue template renamed `c1-module-change.yml` → `module-change.yml`
- README test-count estimate updated to current suite size

## [0.2.0] — 2026-07-17

### Changed
- Renamed package from `aec_c1` to `aec_compiler`
- Rewrote all documentation as standalone open-source project
- Removed contest-specific artifacts and documentation

### Fixed
- Scheduler: added missing WAR/WAW dependency edges (P0 correctness)
- Register allocator: fixed fallback collision when linear-scan pre-mapping is present (P0 correctness)
- Uniformity analysis: extended coverage to `or`, `xor`, `shl`, `fma` opcodes
- Scheduler errors now fail-closed instead of being swallowed as warnings
- Code quality: replaced `del analyses` anti-pattern with `_analyses` parameter naming
- Code quality: replaced broad `except Exception` with specific exception types

### Added
- `pyproject.toml` with build configuration and console_scripts entry points

### Removed
- Dead `ListSchedulerPass` class
- Deprecated agent stub
- Contest artifacts (spec, scoring, hint, screenshots, submission tarball)

## [0.1.0] — 2026-07

### Added
- Initial bootstrap compiler: PTX 9.3 scalar subset → AEC 128-bit machine code
- O0/O2/O3 optimization pipelines
- Linear-scan register allocation with loop awareness
- DDG post-lowering scheduler
- FP32 scalar GEMM loop unrolling
- Local semantic simulator for differential testing
- Comprehensive test suite (170+ tests)

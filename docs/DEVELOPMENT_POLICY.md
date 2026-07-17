# Development Policy

## 1. Repository

- The project repository is `BulletFlying/aec-compiler-toolchain`.
- `origin` must point to this repository.

## 2. Branching

- `main` is the accepted baseline, not a development workspace.
- Feature work happens on short-lived branches.
- Branch naming: `feat/<description>`, `fix/<description>`, `refactor/<description>`.

## 3. Pull Requests

- All changes to `main` go through PRs (except emergency doc fixes).
- PRs must fill the repository template.
- Required checks before merge: tests pass, compilation clean, diff clean.

## 4. Module Changes

New or materially changed modules must document:
- Responsibility and interface
- Analyses consumed/preserved/invalidated
- Semantic invariants
- Conservative fallback behavior
- Test coverage plan

## 5. Verification Baseline

Every change must pass:
```bash
python -m compileall -q src compiler disassembler tests
python -m pytest -q tests
git diff --check
```

## 6. Code Review Priority

1. Correctness: wrong encoding, OOB, register overwrite
2. Generalization: failures under register/label rename, shape variation
3. Architecture: module boundary violations, self-proving cycles
4. Silently wrong behavior: fallback bypasses, legacy path abuse
5. Performance opportunities

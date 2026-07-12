#!/usr/bin/env python3
"""Minimal public example of how the evaluator calls a group's Makefile.

This intentionally mirrors the important behavior of test_group_makefiles.py:
the Makefile is outside the case workspace, `make -f` uses an absolute path,
and every target runs with cwd set to an isolated work directory.
"""

from __future__ import annotations

import argparse
import filecmp
import os
import shutil
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parent
DEFAULT_GROUP = ROOT / "test_interface"
DEFAULT_CASES = ROOT / "benchmark"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--group", type=Path, default=DEFAULT_GROUP)
    parser.add_argument("--cases-root", type=Path, default=DEFAULT_CASES)
    parser.add_argument("--case", default="basic01")
    parser.add_argument("--mode", choices=("run", "parallel_run"), default="run")
    parser.add_argument("--filelist", default="filelist.txt")
    parser.add_argument("--top", default="tb2")
    parser.add_argument("--threads", type=int, default=4)
    parser.add_argument("--timeout", type=int, default=300)
    parser.add_argument("--keep-work", action="store_true")
    parser.add_argument(
        "--verilator",
        help="Optional VERILATOR override passed to make, for example /opt/bin/verilator.",
    )
    return parser.parse_args()


def stage_filelist(source: Path, case_dir: Path, work_dir: Path) -> str:
    """Write the evaluator-style filelist with absolute source paths."""
    output = work_dir / source.name
    lines = [f"-I{(case_dir / 'rtl').resolve()}", ""]
    for raw in source.read_text(encoding="utf-8").splitlines():
        stripped = raw.strip()
        if not stripped or stripped.startswith(("#", "//", "+", "-")):
            lines.append(raw)
        elif Path(stripped).is_absolute():
            lines.append(stripped)
        else:
            lines.append(str((source.parent / stripped).resolve()))
    output.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return output.name


def prepare_work(case_dir: Path, work_dir: Path, filelist_name: str, keep: bool) -> str:
    if work_dir.exists() and not keep:
        shutil.rmtree(work_dir)
    work_dir.mkdir(parents=True, exist_ok=True)

    # Runtime data are copied; RTL and testbench sources remain in the case
    # directory and are referenced through absolute paths in the new filelist.
    source_tb = case_dir / "tb"
    target_tb = work_dir / "tb"
    target_tb.mkdir(parents=True, exist_ok=True)
    for source in source_tb.iterdir():
        if not source.is_file():
            continue
        if source.name in {"output.mem", "output_ref.mem"} or source.suffix == ".v":
            continue
        shutil.copy2(source, target_tb / source.name)

    output = target_tb / "output.mem"
    if output.exists():
        output.unlink()
    return stage_filelist(case_dir / filelist_name, case_dir, work_dir)


def run_make(
    makefile: Path,
    work_dir: Path,
    target: str,
    *,
    filelist: str,
    top: str,
    threads: int,
    group_dir: Path,
    timeout: int,
    verilator: str | None,
) -> None:
    command = [
        "make",
        "-f",
        str(makefile),
        target,
        f"FILELIST={filelist}",
        f"TOP={top}",
        f"THREADS={threads}",
        f"SUBMISSION_DIR={group_dir}",
        f"MAKEFILE_DIR={group_dir}",
    ]
    if verilator:
        command.append(f"VERILATOR={verilator}")

    env = os.environ.copy()
    env["SUBMISSION_DIR"] = str(group_dir)
    env["MAKEFILE_DIR"] = str(group_dir)
    print("$ " + " ".join(command), flush=True)
    subprocess.run(command, cwd=work_dir, env=env, timeout=timeout, check=True)


# python3 test_makefile_interface.py --case sha256 --mode run
def main() -> int:
    args = parse_args()
    group_dir = args.group.resolve()
    cases_root = args.cases_root.resolve()
    case_dir = cases_root / args.case
    makefile = group_dir / "Makefile"

    if not makefile.is_file():
        raise SystemExit(f"missing group Makefile: {makefile}")
    if not case_dir.is_dir():
        raise SystemExit(f"missing case: {case_dir}")
    if args.threads < 1:
        raise SystemExit("--threads must be >= 1")

    work_dir = group_dir / "test" / args.case / args.mode
    filelist = prepare_work(case_dir, work_dir, args.filelist, args.keep_work)

    try:
        for target in ("build", "compile_sim", args.mode):
            run_make(
                makefile,
                work_dir,
                target,
                filelist=filelist,
                top=args.top,
                threads=args.threads,
                group_dir=group_dir,
                timeout=args.timeout,
                verilator=args.verilator,
            )
    except (subprocess.CalledProcessError, subprocess.TimeoutExpired) as exc:
        print(f"FAIL: make invocation failed: {exc}", file=sys.stderr)
        print(f"work_dir: {work_dir}", file=sys.stderr)
        return 1

    expected = case_dir / "tb" / "output_ref.mem"
    actual = work_dir / "tb" / "output.mem"
    if not actual.is_file():
        print(f"FAIL: missing {actual}", file=sys.stderr)
        return 1
    if not filecmp.cmp(expected, actual, shallow=False):
        print("FAIL: tb/output.mem differs from tb/output_ref.mem", file=sys.stderr)
        print(f"expected: {expected}", file=sys.stderr)
        print(f"actual:   {actual}", file=sys.stderr)
        return 1

    print(f"PASS: case={args.case} mode={args.mode} threads={args.threads}")
    print(f"work_dir: {work_dir}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

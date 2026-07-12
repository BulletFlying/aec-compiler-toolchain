#!/usr/bin/env python3
import argparse
import csv
import os
import re
import shlex
import subprocess
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_LIB = str(ROOT / "lib" / "nangate45" / "NangateOpenCellLibrary_typical.lib")
DEFAULT_IMAGE = "my_siliconcompiler_image:latest"
DEFAULT_YOSYS_IN_DOCKER = "/root/.local/bin/yosys"
ABC_COMPRESS2RS = "balance; rewrite; rewrite -z; balance; rewrite -z; balance"
ABC_RESYN2RS = "balance; rewrite; refactor; balance; rewrite; rewrite -z; balance; refactor -z; rewrite -z; balance"
ABC_IF_K6 = "if -K 6 -g -C 8"
ABC_NANGATE_MAP = "&get -n; &dch -f; &nf -D 10000; &put"
ABC_SCRIPTS = {
    "yosys_p1": f"+strash; {ABC_COMPRESS2RS}; {ABC_NANGATE_MAP}",
    "yosys_p2": f"+strash; {ABC_IF_K6}; {ABC_NANGATE_MAP}",
    "yosys_p3": f"+strash; {ABC_RESYN2RS}; {ABC_NANGATE_MAP}",
    "yosys_p4": f"+strash; {ABC_COMPRESS2RS}; {ABC_COMPRESS2RS}; {ABC_NANGATE_MAP}",
    "yosys_p5": f"+strash; {ABC_IF_K6}; {ABC_IF_K6}; {ABC_NANGATE_MAP}",
}


def load_cases(root, split, case_id):
    with open(root / "MANIFEST.csv", newline="") as f:
        rows = list(csv.DictReader(f))
    out = []
    for row in rows:
        if split != "all" and row["split"] != split:
            continue
        if case_id and row["id"] != case_id:
            continue
        if row["split"] == "reserve" and split == "all":
            continue
        out.append(row)
    return out


def parse_log(log_text):
    cells = re.findall(r"Number of cells:\s*([0-9]+)", log_text)
    areas = re.findall(r"Chip area for module '\\[^']+':\s*([0-9.]+)", log_text)
    return (cells[-1] if cells else "", areas[-1] if areas else "")


def write_yosys_script(path, rtl, top, liberty, netlist, abc_script):
    path.write_text("\n".join([
        f"read_verilog -sv {rtl}",
        f"hierarchy -check -top {top}",
        f"synth -top {top} -flatten -noabc",
        f"dfflibmap -liberty {liberty}",
        f"abc -liberty {liberty} -script \"{abc_script}\"",
        "clean",
        f"stat -liberty {liberty}",
        "setundef -zero",
        "splitnets -driver",
        "clean",
        f"write_verilog -noattr -noexpr {netlist}",
        "",
    ]))


def run_case(root, row, args):
    case_dir = root / row["path"]
    flow_name = "custom" if args.abc_script else args.flow
    out_dir = root / "reports" / "yosys" / flow_name / row["id"]
    out_dir.mkdir(parents=True, exist_ok=True)
    rtl = case_dir / row["rtl"]
    netlist = out_dir / "netlist.v"
    ys = out_dir / "run.ys"
    log = out_dir / "yosys.log"
    abc_script = args.abc_script or ABC_SCRIPTS[args.flow]
    write_yosys_script(ys, rtl, row["top"], args.liberty, netlist, abc_script)

    start = time.time()
    if args.docker:
        cmdline = "export PATH=/root/.local/bin:$PATH; " + " ".join([
            shlex.quote(DEFAULT_YOSYS_IN_DOCKER), "-l", shlex.quote(str(log)), "-s", shlex.quote(str(ys))
        ])
        cmd = [
            "docker", "run", "--rm",
            "-v", "/data0:/data0",
            "-v", "/data3:/data3",
            "-w", str(root),
            args.image,
            "/bin/bash", "-lc", cmdline,
        ]
    else:
        cmd = [args.yosys_bin, "-l", str(log), "-s", str(ys)]

    try:
        proc = subprocess.run(cmd, cwd=root, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=args.timeout)
        elapsed = time.time() - start
        log_text = ""
        if log.exists():
            log_text = log.read_text(errors="ignore")
        cells, area = parse_log(log_text + "\n" + proc.stdout + "\n" + proc.stderr)
        status = "ok" if proc.returncode == 0 and cells and area else f"fail_rc{proc.returncode}"
        return {"id": row["id"], "split": row["split"], "name": row["name"], "top": row["top"], "flow": flow_name, "status": status, "elapsed_s": f"{elapsed:.2f}", "cells": cells, "area": area, "log": str(log), "netlist": str(netlist)}
    except subprocess.TimeoutExpired:
        elapsed = time.time() - start
        return {"id": row["id"], "split": row["split"], "name": row["name"], "top": row["top"], "flow": flow_name, "status": "timeout", "elapsed_s": f"{elapsed:.2f}", "cells": "", "area": "", "log": str(log), "netlist": str(netlist)}


def main():
    parser = argparse.ArgumentParser(description="Run Yosys/ABC on the logic synthesis question bank.")
    parser.add_argument("--root", default=Path(__file__).resolve().parents[1], type=Path)
    parser.add_argument("--split", choices=["public", "all"], default="public")
    parser.add_argument("--id", dest="case_id")
    parser.add_argument("--liberty", default=DEFAULT_LIB)
    parser.add_argument("--flow", choices=sorted(ABC_SCRIPTS), default="yosys_p1")
    parser.add_argument("--abc-script", help="Override the ABC script passed to yosys 'abc -script'.")
    parser.add_argument("--timeout", type=int, default=300)
    parser.add_argument("--image", default=DEFAULT_IMAGE)
    parser.add_argument("--yosys-bin", default="yosys")
    parser.add_argument("--docker", dest="docker", action="store_true", default=True)
    parser.add_argument("--no-docker", dest="docker", action="store_false")
    args = parser.parse_args()

    root = args.root.resolve()
    cases = load_cases(root, args.split, args.case_id)
    if not cases:
        raise SystemExit("No cases selected.")
    results = []
    for row in cases:
        print(f"[{row['id']}] {row['name']} top={row['top']}", flush=True)
        result = run_case(root, row, args)
        print(f"  {result['flow']} {result['status']} elapsed={result['elapsed_s']}s cells={result['cells']} area={result['area']}", flush=True)
        results.append(result)

    result_flow = "custom" if args.abc_script else args.flow
    out_csv = root / "reports" / f"yosys_results_{args.split}_{result_flow}.csv"
    out_csv.parent.mkdir(exist_ok=True)
    with open(out_csv, "w", newline="") as f:
        fields = ["id", "split", "name", "top", "flow", "status", "elapsed_s", "cells", "area", "log", "netlist"]
        writer = csv.DictWriter(f, fieldnames=fields)
        writer.writeheader()
        writer.writerows(results)
    print(f"Wrote {out_csv}")


if __name__ == "__main__":
    main()

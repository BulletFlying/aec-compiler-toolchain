#!/usr/bin/env python3
import argparse
import csv
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_LIB = str(ROOT / "lib" / "nangate45" / "NangateOpenCellLibrary_typical.lib")


def split_concat_items(text):
    items = []
    depth = 0
    start = 0
    for idx, char in enumerate(text):
        if char == "{":
            depth += 1
        elif char == "}":
            depth -= 1
        elif char == "," and depth == 0:
            items.append(text[start:idx].strip())
            start = idx + 1
    items.append(text[start:].strip())
    return [item for item in items if item]


def expr_width(expr):
    expr = expr.strip()
    match = re.search(r"\[(\d+)\s*:\s*(\d+)\]\s*$", expr)
    if match:
        return abs(int(match.group(1)) - int(match.group(2))) + 1
    if re.search(r"\[\d+\]\s*$", expr):
        return 1
    match = re.match(r"(\d+)'[bBdDhHoO][0-9a-fA-F_xXzZ]+$", expr)
    if match:
        return int(match.group(1))
    return 1


def const_slice(expr, offset, width):
    match = re.match(r"(\d+)'([bBdDhHoO])([0-9a-fA-F_xXzZ]+)$", expr.strip())
    if not match:
        return None
    total = int(match.group(1))
    base = match.group(2).lower()
    digits = match.group(3).replace("_", "")
    if any(ch in digits.lower() for ch in "xz"):
        if base == "b":
            bits = digits.lower().rjust(total, "0")[-total:]
        else:
            return f"{width}'b" + ("x" * width)
    else:
        value = int(digits, {"b": 2, "o": 8, "d": 10, "h": 16}[base])
        bits = bin(value)[2:].zfill(total)[-total:]
    return f"{width}'b{bits[offset:offset + width]}"


def expr_slice(expr, offset, width):
    expr = expr.strip()
    total = expr_width(expr)
    if offset == 0 and width == total:
        return expr
    const = const_slice(expr, offset, width)
    if const is not None:
        return const
    match = re.search(r"^(.*)\[(\d+)\s*:\s*(\d+)\]\s*$", expr)
    if match:
        base, msb, lsb = match.group(1), int(match.group(2)), int(match.group(3))
        if msb >= lsb:
            hi = msb - offset
            lo = hi - width + 1
        else:
            hi = msb + offset
            lo = hi + width - 1
        return f"{base}[{hi}]" if width == 1 else f"{base}[{hi}:{lo}]"
    return expr if total == width == 1 else None


def format_verilog_expr(expr):
    expr = expr.strip()
    if expr.startswith("\\") and "[" not in expr and not expr.endswith(" "):
        return expr + " "
    return expr


def sanitize_for_opensta(src, dst):
    out = []
    for line in src.read_text(errors="ignore").splitlines():
        match = re.match(r"^(\s*)assign\s+\{(.*)\}\s*=\s*(.*);\s*$", line)
        if not match:
            out.append(line)
            continue
        indent, lhs_text, rhs_text = match.groups()
        lhs_items = split_concat_items(lhs_text)
        rhs = rhs_text.strip()
        if rhs.startswith("{") and rhs.endswith("}"):
            rhs_items = split_concat_items(rhs[1:-1])
        else:
            rhs_items = [rhs]
        rhs_stream = []
        for item in rhs_items:
            rhs_stream.append([item, 0, expr_width(item)])
        rhs_idx = 0
        replacement = []
        ok = True
        for lhs in lhs_items:
            need = expr_width(lhs)
            pieces = []
            while need > 0 and rhs_idx < len(rhs_stream):
                expr, used, width = rhs_stream[rhs_idx]
                take = min(need, width - used)
                piece = expr_slice(expr, used, take)
                if piece is None:
                    ok = False
                    break
                pieces.append(format_verilog_expr(piece))
                used += take
                need -= take
                rhs_stream[rhs_idx][1] = used
                if used == width:
                    rhs_idx += 1
            if not ok or need:
                ok = False
                break
            rhs_expr = pieces[0] if len(pieces) == 1 else "{ " + ", ".join(pieces) + " }"
            replacement.append(f"{indent}assign {lhs} = {rhs_expr};")
        out.extend(replacement if ok else [line])
    dst.write_text("\n".join(out) + "\n")


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


def write_eval_sdc(src, dst):
    text = Path(src).read_text(errors="ignore")
    text = re.sub(r"set\s+CLK_PERIOD\s+[0-9.]+", "set CLK_PERIOD 0.000", text)
    text = re.sub(r"set_input_delay\s+[0-9.]+", "set_input_delay 0.000", text)
    text = re.sub(r"set_output_delay\s+[0-9.]+", "set_output_delay 0.000", text)
    text = re.sub(r"set_max_delay\s+\$CLK_PERIOD", "set_max_delay 0.000", text)
    text = re.sub(r"set_max_delay\s+[0-9.]+", "set_max_delay 0.000", text)
    dst.write_text(text)


def run_case(root, row, args):
    case_dir = root / row["path"]
    yosys_dir = root / "reports" / "yosys" / row["id"]
    netlist = yosys_dir / "netlist.v"
    out_dir = root / "reports" / "opensta" / row["id"]
    out_dir.mkdir(parents=True, exist_ok=True)
    if not netlist.exists():
        return {"id": row["id"], "status": "missing_netlist", "report": str(out_dir)}
    sta_netlist = out_dir / "netlist.opensta.v"
    sanitize_for_opensta(netlist, sta_netlist)
    eval_sdc = out_dir / "constraints.eval.sdc"
    write_eval_sdc(case_dir / "constraints.sdc", eval_sdc)
    tcl = out_dir / "run_sta.tcl"
    tcl.write_text("\n".join([
        f"read_liberty {args.liberty}",
        f"read_verilog {sta_netlist}",
        f"link_design {row['top']}",
        f"read_sdc {eval_sdc}",
        f"report_checks -path_delay max -fields {{slew cap input nets fanout}} -digits 3 -group_count 10 > {out_dir / 'checks.rpt'}",
        f"report_worst_slack > {out_dir / 'wns.rpt'}",
        f"report_tns > {out_dir / 'tns.rpt'}",
        f"report_checks -unconstrained > {out_dir / 'unconstrained.rpt'}",
        "exit",
        "",
    ]))
    log = out_dir / "opensta.log"
    with open(log, "w") as lf:
        proc = subprocess.run([args.sta_bin, str(tcl)], cwd=root, stdout=lf, stderr=subprocess.STDOUT, text=True, timeout=args.timeout)
    log_text = log.read_text(errors="ignore")
    status = "ok" if proc.returncode == 0 and "Error:" not in log_text else f"fail_rc{proc.returncode}"
    if "Error:" in log_text:
        status = "sta_error"
    return {"id": row["id"], "status": status, "report": str(out_dir)}


def main():
    parser = argparse.ArgumentParser(description="Run OpenSTA timing reports for Yosys netlists.")
    parser.add_argument("--root", default=Path(__file__).resolve().parents[1], type=Path)
    parser.add_argument("--split", choices=["public", "all"], default="public")
    parser.add_argument("--id", dest="case_id")
    parser.add_argument("--liberty", default=DEFAULT_LIB)
    parser.add_argument("--sta-bin", default="sta")
    parser.add_argument("--timeout", type=int, default=120)
    args = parser.parse_args()
    root = args.root.resolve()
    for row in load_cases(root, args.split, args.case_id):
        result = run_case(root, row, args)
        print(f"[{row['id']}] {result['status']} {result['report']}")


if __name__ == "__main__":
    main()

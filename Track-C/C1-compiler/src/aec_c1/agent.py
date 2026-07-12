"""Minimal offline optimization agent for C1.

The public C1 materials do not define the JSON schema yet.  This agent keeps a
stable command alive and returns a conservative default configuration.
"""

from __future__ import annotations

import argparse
import json
import sys
from typing import Any


def choose_config(request: dict[str, Any] | None = None) -> dict[str, Any]:
    request = request or {}
    opt_level = request.get("opt_level", "O2")
    return {
        "compiler": "aec-cc",
        "profile": "track_b_v1",
        "opt_level": opt_level,
        "passes": {
            "constant_propagation": True,
            "dce": True,
            "cse": False,
            "licm": False,
            "list_scheduling": False,
        },
        "status": "bootstrap-default",
    }


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(prog="run_agent")
    parser.add_argument("--input-json", type=str, default="")
    args = parser.parse_args(argv)

    try:
        if args.input_json:
            request = json.loads(args.input_json)
        else:
            raw = sys.stdin.read().strip()
            request = json.loads(raw) if raw else {}
    except json.JSONDecodeError as exc:
        print(f"run_agent: error: invalid JSON: {exc}", file=sys.stderr)
        return 1

    print(json.dumps(choose_config(request), sort_keys=True))
    return 0

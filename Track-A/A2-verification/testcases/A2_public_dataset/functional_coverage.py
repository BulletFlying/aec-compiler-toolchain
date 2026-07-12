import json
import os


class FunctionalCoverage:
    def __init__(self, design, coverpoints):
        self.design = design
        self.coverpoints = {
            name: {bin_name: 0 for bin_name in bins}
            for name, bins in coverpoints.items()
        }

    def hit(self, coverpoint, bin_name, count=1):
        self.coverpoints[coverpoint][bin_name] += count

    def write(self, path=None, source="testbench"):
        path = path or os.environ.get(
            "FUNCTIONAL_COVERAGE_OUTPUT", "functional_coverage.json"
        )
        covered = sum(
            hits > 0
            for bins in self.coverpoints.values()
            for hits in bins.values()
        )
        total = sum(len(bins) for bins in self.coverpoints.values())
        result = {
            "functional_coverage": {
                "design": self.design,
                "status": "passed",
                "source": source,
                "covered_bins": covered,
                "total_bins": total,
                "percent": round(100.0 * covered / total, 2) if total else 0.0,
                "coverpoints": [
                    {
                        "name": name,
                        "covered_bins": sum(hits > 0 for hits in bins.values()),
                        "total_bins": len(bins),
                        "bins": [
                            {
                                "name": bin_name,
                                "hits": hits,
                                "covered": hits > 0,
                            }
                            for bin_name, hits in bins.items()
                        ],
                    }
                    for name, bins in self.coverpoints.items()
                ],
            }
        }
        with open(path, "w", encoding="utf-8") as f:
            json.dump(result, f, indent=2)
            f.write("\n")


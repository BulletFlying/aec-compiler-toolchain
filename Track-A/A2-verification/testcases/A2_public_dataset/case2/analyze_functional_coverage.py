import csv
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from functional_coverage import FunctionalCoverage


def bits(value):
    return int(value, 2)


def main():
    coverage = FunctionalCoverage(
        "case2",
        {
            "reset": ["asserted", "deasserted"],
            "source_handshake": ["transfer", "backpressure", "idle"],
            "sink_handshake": ["transfer", "backpressure", "not_ready"],
            "frame": ["last", "partial_keep", "multi_beat"],
            "metadata": ["tid_nonzero", "tdest_nonzero", "user_zero"],
        },
    )
    input_path = os.path.join(os.path.dirname(__file__), "tb", "input.mem")
    output_path = os.path.join(os.path.dirname(__file__), "tb", "output.mem")
    frame_beats = 0

    with open(input_path, newline="") as input_file, open(output_path, newline="") as output_file:
        inputs = csv.reader(input_file)
        outputs = csv.reader(output_file)
        next(inputs)
        next(outputs)
        for input_row, output_row in zip(inputs, outputs):
            rst, _, keep, valid, last, tid, dest, user, ready = map(bits, input_row)
            source_ready, _, _, sink_valid, _, _, _, _ = map(bits, output_row)

            coverage.hit("reset", "asserted" if rst else "deasserted")
            if not valid:
                coverage.hit("source_handshake", "idle")
            elif source_ready:
                coverage.hit("source_handshake", "transfer")
                frame_beats += 1
                if keep != 0xff:
                    coverage.hit("frame", "partial_keep")
                if tid:
                    coverage.hit("metadata", "tid_nonzero")
                if dest:
                    coverage.hit("metadata", "tdest_nonzero")
                if not user:
                    coverage.hit("metadata", "user_zero")
                if last:
                    coverage.hit("frame", "last")
                    if frame_beats > 1:
                        coverage.hit("frame", "multi_beat")
                    frame_beats = 0
            else:
                coverage.hit("source_handshake", "backpressure")

            if not ready:
                coverage.hit("sink_handshake", "not_ready")
            if sink_valid and ready:
                coverage.hit("sink_handshake", "transfer")
            elif sink_valid and not ready:
                coverage.hit("sink_handshake", "backpressure")

    coverage.write(
        path=os.path.join(os.path.dirname(__file__), "functional_coverage.json"),
        source="verified Verilog input/output vector sampling",
    )


if __name__ == "__main__":
    main()

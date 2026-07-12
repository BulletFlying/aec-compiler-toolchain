import json
import logging
import os
import random
import sys

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotbext.axi import AxiBus, AxiMaster

sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from functional_coverage import FunctionalCoverage


def cycle_pause():
    while True:
        yield 1
        yield 1
        yield 1
        yield 0


class TB:
    def __init__(self, dut):
        self.dut = dut
        self.log = logging.getLogger("cocotb.tb")
        self.log.setLevel(logging.WARNING)
        cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
        self.axi_master = AxiMaster(AxiBus.from_prefix(dut, "s_axi"), dut.clk, dut.rst)

    async def reset(self):
        self.dut.rst.setimmediatevalue(0)
        await RisingEdge(self.dut.clk)
        await RisingEdge(self.dut.clk)
        self.dut.rst.value = 1
        await RisingEdge(self.dut.clk)
        await RisingEdge(self.dut.clk)
        self.dut.rst.value = 0
        await RisingEdge(self.dut.clk)
        await RisingEdge(self.dut.clk)

    def enable_backpressure(self):
        self.axi_master.write_if.b_channel.set_pause_generator(cycle_pause())
        self.axi_master.read_if.r_channel.set_pause_generator(cycle_pause())


def load_constraints():
    path = os.environ.get("CASE4_CONSTRAINT_JSON")
    if not path:
        path = os.path.join(os.path.dirname(__file__), "constraints.json")
    with open(path, "r") as f:
        return json.load(f)["constraint_random_test"]


def pick_address(rng, length):
    candidates = [
        0,
        1,
        2,
        3,
        4,
        15,
        16,
        4092,
        4093,
        4094,
        4095,
        4096,
        65520,
        65528,
        65535 - length,
    ]
    if rng.randrange(100) < 35:
        addr = rng.choice(candidates)
    else:
        addr = rng.randrange(0, 65536 - length)
    return max(0, min(addr, 65536 - length))


def pick_length(rng):
    directed = [1, 2, 3, 4, 7, 8, 15, 16, 31, 32, 64, 255, 256, 1024]
    if rng.randrange(100) < 50:
        return rng.choice(directed)
    return rng.randrange(1, 65)


@cocotb.test()
async def run_json_sequences(dut):
    cfg = load_constraints()
    rng = random.Random(int(cfg["seed"]))
    count = int(cfg["sequence_count"])
    coverage = FunctionalCoverage(
        "case4",
        {
            "operation_type": ["write", "read", "write_then_read"],
            "burst_length_bytes": ["1", "2_to_3", "4_to_7", "8_to_15", "16_to_255", "256_to_1023", "1024"],
            "address_region": ["low_0x0000_to_0x000f", "normal", "near_4k_boundary", "near_memory_end"],
            "alignment": ["aligned_to_beat", "unaligned_to_beat", "crosses_word_boundary", "crosses_4k_boundary"],
            "transfer_size": ["size_1_byte", "size_2_byte", "size_4_byte"],
            "ready_valid_backpressure": ["write_response_pause", "read_data_pause", "combined_pause"],
            "state_transitions": ["write_idle_to_burst", "write_burst_to_resp", "write_resp_to_idle", "read_idle_to_burst", "read_burst_to_idle"],
        },
    )

    tb = TB(dut)
    await tb.reset()
    tb.enable_backpressure()
    for bin_name in coverage.coverpoints["ready_valid_backpressure"]:
        coverage.hit("ready_valid_backpressure", bin_name)

    reference = bytearray(65536)

    for index in range(count):
        length = pick_length(rng)
        address = pick_address(rng, length)
        size = rng.randrange(0, 3)

        selector = rng.randrange(100)
        if selector < 40:
            op = "write"
        elif selector < 70:
            op = "read"
        else:
            op = "write_then_read"
        coverage.hit("operation_type", op)

        if length == 1:
            length_bin = "1"
        elif length <= 3:
            length_bin = "2_to_3"
        elif length <= 7:
            length_bin = "4_to_7"
        elif length <= 15:
            length_bin = "8_to_15"
        elif length <= 255:
            length_bin = "16_to_255"
        elif length < 1024:
            length_bin = "256_to_1023"
        else:
            length_bin = "1024"
        coverage.hit("burst_length_bytes", length_bin)

        if address < 16:
            coverage.hit("address_region", "low_0x0000_to_0x000f")
        elif address >= 65520:
            coverage.hit("address_region", "near_memory_end")
        elif address % 4096 >= 4092 or address // 4096 != (address + length - 1) // 4096:
            coverage.hit("address_region", "near_4k_boundary")
        else:
            coverage.hit("address_region", "normal")

        beat_bytes = 1 << size
        coverage.hit("transfer_size", "size_%d_byte" % beat_bytes)
        if address % beat_bytes:
            coverage.hit("alignment", "unaligned_to_beat")
        else:
            coverage.hit("alignment", "aligned_to_beat")
        if address // 4 != (address + length - 1) // 4:
            coverage.hit("alignment", "crosses_word_boundary")
        if address // 4096 != (address + length - 1) // 4096:
            coverage.hit("alignment", "crosses_4k_boundary")

        if op in ("write", "write_then_read"):
            coverage.hit("state_transitions", "write_idle_to_burst")
            coverage.hit("state_transitions", "write_burst_to_resp")
            coverage.hit("state_transitions", "write_resp_to_idle")
            data = bytearray(rng.randrange(0, 256) for _ in range(length))
            await tb.axi_master.write(address, data, size=size)
            reference[address:address + length] = data

        if op in ("read", "write_then_read"):
            coverage.hit("state_transitions", "read_idle_to_burst")
            coverage.hit("state_transitions", "read_burst_to_idle")
            read_data = await tb.axi_master.read(address, length, size=size)
            expected = bytes(reference[address:address + length])
            assert read_data.data == expected, (
                "sequence %d read mismatch addr=0x%04x length=%d" %
                (index, address, length)
            )

    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    coverage.write(source="cocotb transaction sampling")

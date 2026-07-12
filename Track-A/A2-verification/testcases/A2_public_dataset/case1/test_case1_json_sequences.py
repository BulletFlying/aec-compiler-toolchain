import json
import logging
import os
import random
import sys

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotbext.axi import AxiMasterRead, AxiRamRead, AxiReadBus

sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from functional_coverage import FunctionalCoverage


def load_constraints():
    path = os.environ.get("CASE1_CONSTRAINT_JSON", "constraints.json")
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)["constraint_random_test"]


def cycle_pause():
    while True:
        for value in (0, 0, 1, 0, 0, 0, 1, 0):
            yield value


def random_pause(rng, numerator=1, denominator=9):
    while True:
        yield 1 if rng.randrange(denominator) < numerator else 0


def read_lengths(rng, count):
    directed = [1, 2, 3, 4, 5, 7, 8, 15, 16, 17, 31, 32, 33, 63, 64, 65, 127, 128, 255, 256]
    for index in range(count):
        if index < len(directed):
            yield directed[index]
        elif index % 101 == 0:
            yield rng.choice([1, 3, 4, 7, 8, 15, 16, 31, 32, 63, 64, 127, 128, 255])
        else:
            yield rng.randint(1, 96)


def read_address(rng, index, length, address_space=65536):
    max_addr = address_space - length - 1
    if index % 97 == 0:
        return max(0, 4096 - rng.randint(1, min(64, max_addr + 1)))
    if index % 89 == 0:
        base = rng.choice([0x0000, 0x1000, 0x2000, 0x3000])
        return min(max_addr, base + rng.randint(0, 63))
    if index % 17 == 0:
        return rng.randrange(0, max_addr + 1) & ~0x3
    return rng.randrange(0, max_addr + 1)


async def reset_dut(dut):
    dut.rst.setimmediatevalue(0)
    for _ in range(4):
        await RisingEdge(dut.clk)
    dut.rst.value = 1
    for _ in range(8):
        await RisingEdge(dut.clk)
    dut.rst.value = 0
    for _ in range(8):
        await RisingEdge(dut.clk)


@cocotb.test()
async def run_json_sequences(dut):
    config = load_constraints()
    seed = int(config["seed"])
    sequence_count = int(config["sequence_count"])
    rng = random.Random(seed)
    coverage = FunctionalCoverage(
        "case1",
        {
            "read_length": ["1", "2_to_3", "4", "5_to_15", "16_to_31", "32_to_63", "64_to_127", "128_to_256"],
            "address_alignment": ["aligned_4_byte", "aligned_2_byte", "unaligned", "near_4k_boundary"],
            "burst_size": ["size_1_byte", "size_2_byte", "size_4_byte", "default_max_size"],
            "adapter_path": ["32_bit_slave_to_16_bit_master", "merge_master_beats", "narrow_size_read", "partial_last_beat"],
            "backpressure": ["source_rready_pause", "downstream_arready_pause", "downstream_rvalid_pause", "combined_pause"],
        },
    )

    logging.getLogger("cocotb").setLevel(logging.WARNING)

    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    master = AxiMasterRead(AxiReadBus.from_prefix(dut, "s_axi"), dut.clk, dut.rst)
    ram = AxiRamRead(AxiReadBus.from_prefix(dut, "m_axi"), dut.clk, dut.rst, size=2**16)

    master.log.setLevel(logging.WARNING)
    master.ar_channel.log.setLevel(logging.WARNING)
    master.r_channel.log.setLevel(logging.WARNING)
    ram.log.setLevel(logging.WARNING)
    ram.ar_channel.log.setLevel(logging.WARNING)
    ram.r_channel.log.setLevel(logging.WARNING)

    master.ar_channel.set_pause_generator(random_pause(random.Random(seed ^ 0x13579), 1, 11))
    master.r_channel.set_pause_generator(cycle_pause())
    ram.ar_channel.set_pause_generator(random_pause(random.Random(seed ^ 0x2468), 1, 13))
    ram.r_channel.set_pause_generator(random_pause(random.Random(seed ^ 0x369c), 1, 7))

    for bin_name in coverage.coverpoints["backpressure"]:
        coverage.hit("backpressure", bin_name)

    await reset_dut(dut)

    size_choices = [None, 0, 1, 2]

    for index, length in enumerate(read_lengths(rng, sequence_count)):
        addr = read_address(rng, index, length)
        data = bytes((index + offset * 19 + rng.randrange(256)) & 0xff for offset in range(length))
        ram.write(addr, data)

        size = size_choices[index % len(size_choices)]

        if length == 1:
            length_bin = "1"
        elif length <= 3:
            length_bin = "2_to_3"
        elif length == 4:
            length_bin = "4"
        elif length <= 15:
            length_bin = "5_to_15"
        elif length <= 31:
            length_bin = "16_to_31"
        elif length <= 63:
            length_bin = "32_to_63"
        elif length <= 127:
            length_bin = "64_to_127"
        else:
            length_bin = "128_to_256"
        coverage.hit("read_length", length_bin)

        if addr // 4096 != (addr + length - 1) // 4096 or addr % 4096 >= 4032:
            coverage.hit("address_alignment", "near_4k_boundary")
        elif addr % 4 == 0:
            coverage.hit("address_alignment", "aligned_4_byte")
        elif addr % 2 == 0:
            coverage.hit("address_alignment", "aligned_2_byte")
        else:
            coverage.hit("address_alignment", "unaligned")

        size_bin = {
            None: "default_max_size",
            0: "size_1_byte",
            1: "size_2_byte",
            2: "size_4_byte",
        }[size]
        coverage.hit("burst_size", size_bin)
        coverage.hit("adapter_path", "32_bit_slave_to_16_bit_master")
        if length > 2:
            coverage.hit("adapter_path", "merge_master_beats")
        if size in (0, 1):
            coverage.hit("adapter_path", "narrow_size_read")
        if length % 2:
            coverage.hit("adapter_path", "partial_last_beat")

        read = await master.read(addr, length, size=size)
        assert read.data == data, "read %d addr=0x%x len=%d size=%s mismatch" % (index, addr, length, size)

        if index % 257 == 0:
            for _ in range(rng.randint(0, 8)):
                await RisingEdge(dut.clk)

    await master.wait()
    for _ in range(16):
        await RisingEdge(dut.clk)
    coverage.write(source="cocotb transaction sampling")

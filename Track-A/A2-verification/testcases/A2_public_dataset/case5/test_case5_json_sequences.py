import json
import logging
import os
import random
import sys

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge

sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from functional_coverage import FunctionalCoverage


BASES = [
    [0x00000000, 0x10000000],
    [0x01000000, 0x11000000],
    [0x02000000, 0x12000000],
    [0x03000000, 0x13000000],
]
SECURE = [False, False, True, False]
REGION_WIDTH = 24
REGION_SIZE = 1 << REGION_WIDTH


def load_constraints():
    path = os.environ.get("CASE5_CONSTRAINT_JSON", "constraints.json")
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)["constraint_random_test"]


def bit(signal):
    return int(signal.value)


def expected_decode(addr, prot):
    for master, regions in enumerate(BASES):
        for region, base in enumerate(regions):
            if (addr >> REGION_WIDTH) == (base >> REGION_WIDTH):
                if SECURE[master] and (prot & 0x2):
                    return None, None, True
                return master, region, False
    return None, None, True


def sample_transaction(coverage, addr, prot, ready_mode, hold_cycles):
    master, region, decerr = expected_decode(addr, prot)
    if decerr:
        secure_region = any(
            (addr >> REGION_WIDTH) == (base >> REGION_WIDTH)
            for base in BASES[2]
        )
        coverage.hit(
            "address_decode",
            "secure_denied" if secure_region and (prot & 0x2) else "unmapped",
        )
        if secure_region and (prot & 0x2):
            coverage.hit("protection", "secure_master_denied")
    else:
        coverage.hit("address_decode", "M%d:R%d" % (master, region))
        coverage.hit(
            "protection",
            "secure_master_accepted" if SECURE[master] else "nonsecure_master_accepted",
        )

    ready_bin = ["all_ready", "address_first", "metadata_first"][ready_mode % 3]
    coverage.hit("ready_order", ready_bin)
    coverage.hit("hold_cycles", str(min(hold_cycles, 2)))


async def reset_dut(dut):
    dut.rst.setimmediatevalue(0)
    dut.s_axi_aid.setimmediatevalue(0)
    dut.s_axi_aaddr.setimmediatevalue(0)
    dut.s_axi_aprot.setimmediatevalue(0)
    dut.s_axi_aqos.setimmediatevalue(0)
    dut.s_axi_avalid.setimmediatevalue(0)
    dut.m_axi_aready.setimmediatevalue(0)
    dut.m_wc_ready.setimmediatevalue(0)
    dut.m_rc_ready.setimmediatevalue(0)
    dut.s_cpl_id.setimmediatevalue(0)
    dut.s_cpl_valid.setimmediatevalue(0)

    for _ in range(4):
        await RisingEdge(dut.clk)
    dut.rst.value = 1
    for _ in range(8):
        await RisingEdge(dut.clk)
    dut.rst.value = 0
    for _ in range(8):
        await RisingEdge(dut.clk)


async def pulse_completion(dut, aid, cycles=1):
    for _ in range(cycles):
        dut.s_cpl_id.value = aid
        dut.s_cpl_valid.value = 1
        await RisingEdge(dut.clk)
        dut.s_cpl_valid.value = 0
        await RisingEdge(dut.clk)


async def wait_for_issue_outputs(dut, expect_decerr, expect_master, expect_region, timeout=80):
    for _ in range(timeout):
        await RisingEdge(dut.clk)
        if expect_decerr:
            if bit(dut.m_wc_valid) and bit(dut.m_rc_valid):
                assert bit(dut.m_axi_avalid) == 0
                assert bit(dut.m_wc_decerr) == 1
                assert bit(dut.m_rc_decerr) == 1
                return
        else:
            if bit(dut.m_axi_avalid) and bit(dut.m_wc_valid):
                assert bit(dut.m_wc_decerr) == 0
                assert bit(dut.m_rc_valid) == 0
                assert bit(dut.m_select) == expect_master
                assert bit(dut.m_wc_select) == expect_master
                assert bit(dut.m_axi_aregion) == expect_region
                return

    raise AssertionError("timed out waiting for address decode outputs")


async def consume_outputs(dut, expect_decerr, ready_mode, timeout=80):
    ready_seen = False

    async def step(addr_ready, wc_ready, rc_ready):
        dut.m_axi_aready.value = addr_ready
        dut.m_wc_ready.value = wc_ready
        dut.m_rc_ready.value = rc_ready
        await RisingEdge(dut.clk)
        return bit(dut.s_axi_aready) == 1

    if expect_decerr:
        mode = ready_mode % 3
        if mode == 0:
            ready_seen = await step(0, 1, 1)
        elif mode == 1:
            ready_seen = await step(0, 1, 0)
            if not ready_seen:
                ready_seen = await step(0, 0, 1)
        else:
            ready_seen = await step(0, 0, 1)
            if not ready_seen:
                ready_seen = await step(0, 1, 0)
    else:
        mode = ready_mode % 3
        if mode == 0:
            ready_seen = await step(1, 1, 0)
        elif mode == 1:
            ready_seen = await step(1, 0, 0)
            if not ready_seen:
                ready_seen = await step(0, 1, 0)
        else:
            ready_seen = await step(0, 1, 0)
            if not ready_seen:
                ready_seen = await step(1, 0, 0)

    for _ in range(timeout):
        if ready_seen:
            return
        ready_seen = await step(1, 1, 1)

    raise AssertionError("timed out waiting for source address ready")


async def issue_address(dut, aid, addr, prot, qos, ready_mode=0, hold_cycles=0, auto_complete=True, coverage=None):
    expect_master, expect_region, expect_decerr = expected_decode(addr, prot)
    if coverage is not None:
        sample_transaction(coverage, addr, prot, ready_mode, hold_cycles)

    dut.m_axi_aready.value = 0
    dut.m_wc_ready.value = 0
    dut.m_rc_ready.value = 0
    dut.s_axi_aid.value = aid
    dut.s_axi_aaddr.value = addr
    dut.s_axi_aprot.value = prot
    dut.s_axi_aqos.value = qos
    dut.s_axi_avalid.value = 1

    await wait_for_issue_outputs(dut, expect_decerr, expect_master, expect_region)

    for _ in range(hold_cycles):
        await RisingEdge(dut.clk)
        if expect_decerr:
            assert bit(dut.m_wc_valid) == 1
            assert bit(dut.m_rc_valid) == 1
        else:
            assert bit(dut.m_axi_avalid) == 1
            assert bit(dut.m_wc_valid) == 1

    await consume_outputs(dut, expect_decerr, ready_mode)

    dut.s_axi_avalid.value = 0
    dut.m_axi_aready.value = 0
    dut.m_wc_ready.value = 0
    dut.m_rc_ready.value = 0
    await RisingEdge(dut.clk)

    if not expect_decerr and auto_complete:
        await pulse_completion(dut, aid)
        if coverage is not None:
            coverage.hit("completion", "normal_completion")

    return not expect_decerr


async def issue_blocked_then_release(dut, aid, addr, prot, qos, release_id, block_cycles, ready_mode, coverage=None):
    expect_master, expect_region, expect_decerr = expected_decode(addr, prot)
    assert not expect_decerr
    if coverage is not None:
        sample_transaction(coverage, addr, prot, ready_mode, 0)
        coverage.hit("admission_control", "same_id_different_destination")
        coverage.hit("completion", "completion_releases_blocked_request")

    dut.m_axi_aready.value = 0
    dut.m_wc_ready.value = 0
    dut.m_rc_ready.value = 0
    dut.s_axi_aid.value = aid
    dut.s_axi_aaddr.value = addr
    dut.s_axi_aprot.value = prot
    dut.s_axi_aqos.value = qos
    dut.s_axi_avalid.value = 1

    for _ in range(block_cycles):
        await RisingEdge(dut.clk)
        assert bit(dut.s_axi_aready) == 0
        assert bit(dut.m_axi_avalid) == 0
        assert bit(dut.m_wc_valid) == 0
        assert bit(dut.m_rc_valid) == 0

    dut.s_cpl_id.value = release_id
    dut.s_cpl_valid.value = 1
    await RisingEdge(dut.clk)
    dut.s_cpl_valid.value = 0
    await wait_for_issue_outputs(dut, False, expect_master, expect_region)

    await consume_outputs(dut, False, ready_mode)
    dut.s_axi_avalid.value = 0
    dut.m_axi_aready.value = 0
    dut.m_wc_ready.value = 0
    dut.m_rc_ready.value = 0
    await RisingEdge(dut.clk)


def directed_cases():
    cases = []
    for master, regions in enumerate(BASES):
        for region, base in enumerate(regions):
            cases.append((master * 3 + region, base + 0x40 + region * 0x100, 0, master + region))
    cases.extend(
        [
            (9, 0x02001000, 0x2, 3),
            (10, 0x12002000, 0x2, 4),
            (11, 0x40000000, 0, 5),
            (12, 0xffffffff, 0, 6),
        ]
    )
    return cases


def random_case(rng):
    selector = rng.randrange(100)
    aid = rng.randrange(16)
    qos = rng.randrange(16)

    if selector < 68:
        master = rng.randrange(len(BASES))
        region = rng.randrange(len(BASES[master]))
        addr = BASES[master][region] + rng.randrange(REGION_SIZE)
        if SECURE[master]:
            prot = rng.choice([0, 1, 4, 5])
        else:
            prot = rng.randrange(8)
        return aid, addr, prot, qos

    if selector < 84:
        region = rng.randrange(len(BASES[2]))
        addr = BASES[2][region] + rng.randrange(REGION_SIZE)
        return aid, addr, rng.choice([2, 3, 6, 7]), qos

    addr = rng.choice([0x04000000, 0x20000000, 0x3ffff000, 0xf0000000]) + rng.randrange(0, 4096)
    return aid, addr & 0xffffffff, rng.randrange(8), qos


@cocotb.test()
async def run_json_sequences(dut):
    config = load_constraints()
    seed = int(config["seed"])
    sequence_count = int(config["sequence_count"])
    rng = random.Random(seed)
    coverage = FunctionalCoverage(
        "case5",
        {
            "address_decode": ["M0:R0", "M0:R1", "M1:R0", "M1:R1", "M2:R0", "M2:R1", "M3:R0", "M3:R1", "unmapped", "secure_denied"],
            "protection": ["secure_master_accepted", "secure_master_denied", "nonsecure_master_accepted"],
            "ready_order": ["all_ready", "address_first", "metadata_first"],
            "hold_cycles": ["0", "1", "2"],
            "admission_control": ["same_id_same_destination", "same_id_different_destination", "all_thread_slots_active", "accept_limit_blocked"],
            "completion": ["normal_completion", "completion_releases_blocked_request", "multiple_completions_same_id"],
        },
    )

    logging.getLogger("cocotb").setLevel(logging.WARNING)
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    await reset_dut(dut)

    issued = 0

    for index, (aid, addr, prot, qos) in enumerate(directed_cases()):
        await issue_address(dut, aid, addr, prot, qos, ready_mode=index, hold_cycles=index % 4, coverage=coverage)
        issued += 1

    await issue_address(dut, 1, BASES[0][0] + 0x1000, 0, 0, auto_complete=False, coverage=coverage)
    issued += 1
    await issue_blocked_then_release(dut, 1, BASES[1][0] + 0x2000, 0, 0, 1, 6, 1, coverage=coverage)
    issued += 1
    await pulse_completion(dut, 1)

    for slot, aid in enumerate([3, 4, 5, 6]):
        master = slot % len(BASES)
        region = slot % len(BASES[master])
        await issue_address(dut, aid, BASES[master][region] + 0x1800 + slot * 0x100, 0, slot, auto_complete=False, coverage=coverage)
        issued += 1
    coverage.hit("admission_control", "all_thread_slots_active")
    await issue_blocked_then_release(dut, 7, BASES[3][1] + 0x2800, 0, 0, 3, 5, 0, coverage=coverage)
    issued += 1
    for aid in [4, 5, 6, 7]:
        await pulse_completion(dut, aid)

    for _ in range(4):
        await issue_address(dut, 2, BASES[0][1] + 0x3000, 0, 0, auto_complete=False, coverage=coverage)
        issued += 1
    coverage.hit("admission_control", "same_id_same_destination")
    coverage.hit("admission_control", "accept_limit_blocked")
    await issue_blocked_then_release(dut, 2, BASES[0][1] + 0x4000, 0, 0, 2, 5, 2, coverage=coverage)
    issued += 1
    await pulse_completion(dut, 2, cycles=4)
    coverage.hit("completion", "multiple_completions_same_id")

    while issued < sequence_count:
        aid, addr, prot, qos = random_case(rng)
        await issue_address(
            dut,
            aid,
            addr,
            prot,
            qos,
            ready_mode=issued,
            hold_cycles=(issued % 5 == 0) + (issued % 37 == 0),
            coverage=coverage,
        )
        issued += 1

        if issued % 257 == 0:
            for _ in range(rng.randint(0, 6)):
                await RisingEdge(dut.clk)

    for _ in range(16):
        await RisingEdge(dut.clk)
    coverage.write(source="cocotb transaction and directed-scenario sampling")

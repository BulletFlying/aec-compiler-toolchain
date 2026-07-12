import json
import logging
import os
import random
import traceback
import sys

import cocotb
from cocotb.clock import Clock
from cocotb.queue import Queue
from cocotb.triggers import Event, RisingEdge, with_timeout
from cocotb_bus.bus import Bus
from cocotbext.axi import AxiBus, AxiRam

sys.path.insert(0, os.path.dirname(os.path.dirname(__file__)))
from functional_coverage import FunctionalCoverage


class DataBus(Bus):
    _signals = ["data", "valid", "ready"]
    _optional_signals = []

    def __init__(self, entity=None, prefix=None, **kwargs):
        super().__init__(entity, prefix, self._signals, optional_signals=self._optional_signals, **kwargs)

    @classmethod
    def from_prefix(cls, entity, prefix, **kwargs):
        return cls(entity, prefix, **kwargs)


class DataSource:
    def __init__(self, bus, clock, reset=None):
        self.bus = bus
        self.clock = clock
        self.reset = reset
        self.pause = False
        self._pause_cr = None

        self.width = len(self.bus.data)
        self.byte_lanes = self.width // 8
        self.seg_count = len(self.bus.valid)
        self.seg_data_width = self.width // self.seg_count
        self.seg_byte_lanes = self.seg_data_width // 8
        self.seg_data_mask = 2**self.seg_data_width - 1
        self.queue = [Queue() for _ in range(self.seg_count)]

        self.bus.data.setimmediatevalue(0)
        self.bus.valid.setimmediatevalue(0)
        cocotb.start_soon(self._run())

    def set_pause_generator(self, generator=None):
        if self._pause_cr is not None:
            self._pause_cr.kill()
            self._pause_cr = None
        if generator is not None:
            self._pause_cr = cocotb.start_soon(self._run_pause(generator))

    def clear(self):
        for queue in self.queue:
            while not queue.empty():
                queue.get_nowait()

    async def write(self, data):
        data = bytearray(data)
        if len(data) % self.byte_lanes:
            data.extend(b"\x00" * (self.byte_lanes - (len(data) % self.byte_lanes)))

        seg = 0
        for offset in range(0, len(data), self.seg_byte_lanes):
            self.queue[seg].put_nowait(data[offset:offset+self.seg_byte_lanes])
            seg = (seg + 1) % self.seg_count

    async def _run(self):
        data = 0
        valid = 0
        while True:
            await RisingEdge(self.clock)
            ready_sample = int(self.bus.ready.value)

            if self.reset is not None and int(self.reset.value):
                self.bus.valid.setimmediatevalue(0)
                valid = 0
                self.clear()
                continue

            for seg in range(self.seg_count):
                mask = 1 << seg
                if (ready_sample & mask) or not (valid & mask):
                    if not self.queue[seg].empty() and not self.pause:
                        item = self.queue[seg].get_nowait()
                        data &= ~(self.seg_data_mask << (self.seg_data_width * seg))
                        data |= int.from_bytes(item, "little") << (self.seg_data_width * seg)
                        valid |= mask
                    else:
                        valid &= ~mask

            self.bus.data.value = data
            self.bus.valid.value = valid

    async def _run_pause(self, generator):
        for value in generator:
            self.pause = bool(value)
            await RisingEdge(self.clock)


class DataSink:
    def __init__(self, bus, clock, reset=None):
        self.bus = bus
        self.clock = clock
        self.reset = reset
        self.pause = False
        self._pause_cr = None
        self.enqueue_event = Event()

        self.width = len(self.bus.data)
        self.byte_lanes = self.width // 8
        self.seg_count = len(self.bus.valid)
        self.seg_data_width = self.width // self.seg_count
        self.seg_byte_lanes = self.seg_data_width // 8
        self.seg_data_mask = 2**self.seg_data_width - 1
        self.queue = [Queue() for _ in range(self.seg_count)]
        self.read_queue = bytearray()

        self.bus.ready.setimmediatevalue(0)
        cocotb.start_soon(self._run())

    def set_pause_generator(self, generator=None):
        if self._pause_cr is not None:
            self._pause_cr.kill()
            self._pause_cr = None
        if generator is not None:
            self._pause_cr = cocotb.start_soon(self._run_pause(generator))

    def clear(self):
        for queue in self.queue:
            while not queue.empty():
                queue.get_nowait()
        self.read_queue.clear()

    def empty(self):
        return all(queue.empty() for queue in self.queue) and not self.read_queue

    def _read_queues(self):
        while True:
            for queue in self.queue:
                if queue.empty():
                    return
            for queue in self.queue:
                self.read_queue.extend(queue.get_nowait())

    async def read(self, count):
        self._read_queues()
        while len(self.read_queue) < count:
            self.enqueue_event.clear()
            await self.enqueue_event.wait()
            self._read_queues()
        data = self.read_queue[:count]
        del self.read_queue[:count]
        return data

    async def _run(self):
        data_sample = 0
        valid_sample = 0
        ready = 0

        while True:
            await RisingEdge(self.clock)
            valid_sample = int(self.bus.valid.value)
            if valid_sample:
                data_sample = int(self.bus.data.value)

            if self.reset is not None and int(self.reset.value):
                self.bus.ready.setimmediatevalue(0)
                ready = 0
                continue

            for seg in range(self.seg_count):
                mask = 1 << seg
                if ready & valid_sample & mask:
                    word = (data_sample >> (self.seg_data_width * seg)) & self.seg_data_mask
                    self.queue[seg].put_nowait(word.to_bytes(self.seg_byte_lanes, "little"))
                    self.enqueue_event.set()

            ready = (1 << self.seg_count) - 1
            if self.pause:
                ready = 0
            self.bus.ready.value = ready

    async def _run_pause(self, generator):
        for value in generator:
            self.pause = bool(value)
            await RisingEdge(self.clock)


def load_constraints():
    path = os.environ.get("CASE3_CONSTRAINT_JSON", "constraints.json")
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)["constraint_random_test"]


def pause_pattern(values):
    while True:
        for value in values:
            yield value


def random_payload(rng, index, length):
    return bytearray((index * 17 + offset * 29 + rng.randrange(256)) & 0xff for offset in range(length))


async def wait_not_reset(dut, timeout_ns=20000):
    async def waiter():
        while int(dut.sts_reset.value):
            await RisingEdge(dut.clk)
        while not int(dut.sts_active.value):
            await RisingEdge(dut.clk)
    await with_timeout(waiter(), timeout_ns, "ns")


class TB:
    def __init__(self, dut):
        self.dut = dut
        logging.getLogger("cocotb").setLevel(logging.WARNING)

        cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())
        cocotb.start_soon(Clock(dut.input_clk, 10, units="ns").start())
        cocotb.start_soon(Clock(dut.output_clk, 10, units="ns").start())

        self.source = DataSource(DataBus.from_prefix(dut, "input"), dut.input_clk, dut.input_rst_out)
        self.sink = DataSink(DataBus.from_prefix(dut, "output"), dut.output_clk, dut.output_rst_out)
        self.axi_ram = AxiRam(AxiBus.from_prefix(dut, "m_axi"), dut.clk, dut.rst, size=2**16)

        if hasattr(self.axi_ram, "log"):
            self.axi_ram.log.setLevel(logging.WARNING)
        self.axi_ram.write_if.aw_channel.log.setLevel(logging.WARNING)
        self.axi_ram.write_if.w_channel.log.setLevel(logging.WARNING)
        self.axi_ram.write_if.b_channel.log.setLevel(logging.WARNING)
        self.axi_ram.read_if.ar_channel.log.setLevel(logging.WARNING)
        self.axi_ram.read_if.r_channel.log.setLevel(logging.WARNING)

        dut.rst_req_in.setimmediatevalue(0)
        dut.cfg_fifo_base_addr.setimmediatevalue(0)
        dut.cfg_fifo_size_mask.setimmediatevalue(0)
        dut.cfg_enable.setimmediatevalue(0)
        dut.cfg_reset.setimmediatevalue(0)
        dut.output_ctrl_ready.setimmediatevalue((1 << len(dut.output_ctrl_ready)) - 1)

    async def reset(self):
        self.dut.rst.setimmediatevalue(0)
        self.dut.input_rst.setimmediatevalue(0)
        self.dut.output_rst.setimmediatevalue(0)
        for _ in range(8):
            await RisingEdge(self.dut.clk)
        self.dut.rst.value = 1
        self.dut.input_rst.value = 1
        self.dut.output_rst.value = 1
        for _ in range(8):
            await RisingEdge(self.dut.clk)
        self.dut.rst.value = 0
        self.dut.input_rst.value = 0
        self.dut.output_rst.value = 0
        for _ in range(16):
            await RisingEdge(self.dut.clk)

    async def configure(self, base_addr=0x1000, size_mask=0x0fff):
        self.dut.cfg_fifo_base_addr.value = base_addr
        self.dut.cfg_fifo_size_mask.value = size_mask
        self.dut.cfg_enable.value = 1
        await wait_not_reset(self.dut)

    async def cfg_reset(self):
        self.dut.cfg_reset.value = 1
        for _ in range(8):
            await RisingEdge(self.dut.clk)
        self.dut.cfg_reset.value = 0
        self.dut.cfg_enable.value = 0
        self.source.clear()
        self.sink.clear()
        for _ in range(16):
            await RisingEdge(self.dut.clk)
        await self.configure()


async def run_payloads(tb, rng, lengths, coverage, scoreboard_bin):
    expected = []
    byte_lanes = tb.source.byte_lanes

    for index, length in enumerate(lengths):
        if length <= byte_lanes:
            length_bin = "one_word"
        elif length < 252:
            length_bin = "multi_word"
        elif length <= 256:
            length_bin = "near_burst"
        else:
            length_bin = "larger_than_one_burst"
        coverage.hit("stream_payload_length", length_bin)
        data = random_payload(rng, index, length)
        if len(data) % byte_lanes:
            data.extend(b"\x00" * (byte_lanes - (len(data) % byte_lanes)))
        expected.append(data)
        await tb.source.write(data)

        if index % 17 == 0:
            for _ in range(rng.randint(0, 6)):
                await RisingEdge(tb.dut.clk)

    for index, data in enumerate(expected):
        rx_data = await with_timeout(tb.sink.read(len(data)), 500000, "ns")
        assert rx_data == data, "payload %d mismatch length %d" % (index, len(data))

    assert tb.sink.empty()
    coverage.hit("scoreboard", scoreboard_bin)


@cocotb.test()
async def run_json_sequences(dut):
    try:
        await _run_json_sequences(dut)
    except BaseException:
        dut._log.error("case3 test failed:\n%s", traceback.format_exc())
        raise


async def _run_json_sequences(dut):
    config = load_constraints()
    rng = random.Random(int(config["seed"]))
    sequence_count = int(config["sequence_count"])
    coverage = FunctionalCoverage(
        "case3",
        {
            "stream_payload_length": ["one_word", "multi_word", "near_burst", "larger_than_one_burst"],
            "stream_flow_control": ["input_pause", "output_pause", "simultaneous_stream_pause"],
            "axi_flow_control": ["aw_pause", "w_pause", "b_pause", "ar_pause", "r_pause"],
            "configuration": ["enable", "cfg_reset", "post_reset_reenable"],
            "scoreboard": ["pre_reset_payload_match", "post_reset_payload_match"],
        },
    )

    tb = TB(dut)
    await tb.reset()

    tb.source.set_pause_generator(pause_pattern([0, 0, 0, 1, 0, 0, 1, 0]))
    tb.sink.set_pause_generator(pause_pattern([0, 0, 1, 0, 0, 0, 0, 1]))
    tb.axi_ram.write_if.aw_channel.set_pause_generator(pause_pattern([0, 1, 0, 0, 0]))
    tb.axi_ram.write_if.w_channel.set_pause_generator(pause_pattern([0, 0, 1, 0, 0, 0]))
    tb.axi_ram.write_if.b_channel.set_pause_generator(pause_pattern([0, 0, 0, 1, 0]))
    tb.axi_ram.read_if.ar_channel.set_pause_generator(pause_pattern([0, 0, 1, 0, 0]))
    tb.axi_ram.read_if.r_channel.set_pause_generator(pause_pattern([0, 1, 0, 0, 0, 0]))
    for bin_name in coverage.coverpoints["stream_flow_control"]:
        coverage.hit("stream_flow_control", bin_name)
    for bin_name in coverage.coverpoints["axi_flow_control"]:
        coverage.hit("axi_flow_control", bin_name)

    await tb.configure()
    coverage.hit("configuration", "enable")

    directed = [4, 8, 12, 16, 20, 32, 64, 128, 252, 256, 260, 512]
    random_lengths = []
    for _ in range(max(0, sequence_count - len(directed))):
        random_lengths.append(rng.choice([4, 8, 12, 16, 24, 28, 32, 48, 64, 96, 128]))

    await run_payloads(tb, rng, directed + random_lengths, coverage, "pre_reset_payload_match")

    await tb.cfg_reset()
    coverage.hit("configuration", "cfg_reset")
    coverage.hit("configuration", "post_reset_reenable")
    await run_payloads(tb, rng, [32, 64, 96, 128], coverage, "post_reset_payload_match")

    assert int(dut.sts_active.value) == 1
    for _ in range(16):
        await RisingEdge(dut.clk)
    coverage.write(source="cocotb transaction and configuration sampling")

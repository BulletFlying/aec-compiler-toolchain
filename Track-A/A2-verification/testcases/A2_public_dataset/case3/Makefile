TOPLEVEL_LANG = verilog

SIM ?= vcs
WAVES ?= 0

COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 1ps

TOPLEVEL = case3_cocotb_top
MODULE = test_case3_json_sequences

CASE_ROOT = $(abspath .)

VERILOG_SOURCES += $(CASE_ROOT)/rtl/case3.v
VERILOG_SOURCES += $(CASE_ROOT)/rtl/axi_vfifo_raw_wr.v
VERILOG_SOURCES += $(CASE_ROOT)/rtl/axi_vfifo_raw_rd.v
VERILOG_SOURCES += $(abspath case3_cocotb_top.v)

include $(shell cocotb-config --makefiles)/Makefile.sim

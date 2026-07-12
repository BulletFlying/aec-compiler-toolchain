TOPLEVEL_LANG = verilog

SIM ?= vcs
WAVES ?= 0

COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 1ps

TOPLEVEL = case5_cocotb_top
MODULE = test_case5_json_sequences

CASE_ROOT = $(abspath .)

VERILOG_SOURCES += $(CASE_ROOT)/rtl/case5.v
VERILOG_SOURCES += $(abspath case5_cocotb_top.v)

include $(shell cocotb-config --makefiles)/Makefile.sim

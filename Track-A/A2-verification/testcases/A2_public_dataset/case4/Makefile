TOPLEVEL_LANG = verilog

SIM ?= vcs
WAVES ?= 0

COCOTB_HDL_TIMEUNIT = 1ns
COCOTB_HDL_TIMEPRECISION = 1ps

TOPLEVEL = axi_ram
MODULE = test_case4_json_sequences

CASE_ROOT = $(abspath .)

VERILOG_SOURCES += $(CASE_ROOT)/rtl/case4.v

include $(shell cocotb-config --makefiles)/Makefile.sim

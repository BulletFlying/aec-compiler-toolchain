SHELL := /bin/bash

TOOL := bin/synth_tool
RTL ?=
TOP ?=
SDC ?=
LIBERTY ?=
CONFIG ?= config.json
CIRCUIT ?=
POINT ?= 1
OUT_DIR ?= output

.PHONY: build synth clean

# Replace this recipe with the build command for your source tree.
build:
	$(MAKE) -C src -j1
	test -x "$(TOOL)"

# Keep the variables and mandatory output path unchanged.
synth:
	test -x "$(TOOL)"
	test -n "$(RTL)"
	test -n "$(TOP)"
	test -n "$(SDC)"
	test -n "$(LIBERTY)"
	test -r "$(CONFIG)"
	test -n "$(CIRCUIT)"
	test "$(POINT)" -ge 1
	mkdir -p "$(OUT_DIR)"
	"$(TOOL)" \
	  --rtl "$(RTL)" \
	  --top "$(TOP)" \
	  --sdc "$(SDC)" \
	  --liberty "$(LIBERTY)" \
	  --config "$(CONFIG)" \
	  --circuit "$(CIRCUIT)" \
	  --point "$(POINT)" \
	  --output "$(OUT_DIR)/netlist.v"
	test -s "$(OUT_DIR)/netlist.v"

clean:
	$(MAKE) -C src clean || true
	rm -rf build bin

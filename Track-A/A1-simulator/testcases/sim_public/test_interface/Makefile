## Verilator example implementing the competition Makefile interface.
##
## The official Python harness invokes this file with an absolute `make -f`
## path, but sets cwd to an isolated per-case work directory.  Therefore:
##   * generated files and relative FILELIST paths belong to $(CURDIR);
##   * submitted sources are located through $(SUBMISSION_DIR)/src.

VERILATOR ?= /data1/home/tangjiaping/tools/verilator-5.036/bin/verilator

FILELIST ?= filelist.txt
TOP ?= tb
THREADS ?= 4
SIM_EXE ?= sim.out

SUBMISSION_DIR ?= $(abspath $(dir $(firstword $(MAKEFILE_LIST))))
MAKEFILE_DIR ?= $(SUBMISSION_DIR)
SRC_DIR ?= $(SUBMISSION_DIR)/src

BUILD_JOBS ?= 0
RUN_ARGS ?=
PARALLEL_RUN_ARGS ?=
VERILATOR_CFLAGS ?= -std=c++20 -fcoroutines

SIMULATOR ?= ./simulator
OBJ_ROOT ?= obj_dir_interface
SINGLE_OBJ_DIR ?= $(OBJ_ROOT)/single
PARALLEL_OBJ_DIR ?= $(OBJ_ROOT)/parallel_$(THREADS)
PARALLEL_SIM_EXE ?= $(SIM_EXE).parallel.$(THREADS)

VERILATOR_PATH := $(shell command -v "$(VERILATOR)" 2>/dev/null)

VERILATOR_FLAGS ?= \
	--timing \
	-Wno-fatal \
	-Wno-DECLFILENAME \
	-Wno-WIDTHEXPAND \
	-Wno-WIDTHTRUNC \
	-Wno-UNUSEDSIGNAL \
	-Wno-TIMESCALEMOD \
	-Wno-CMPCONST

.PHONY: build compile_sim run parallel_run clean
.DELETE_ON_ERROR:

build:
	@test -d "$(SRC_DIR)" || { \
		echo "ERROR: source directory not found: $(SRC_DIR)" >&2; \
		exit 2; \
	}
	@test -n "$(VERILATOR_PATH)" || { \
		echo "ERROR: Verilator not found: $(VERILATOR)" >&2; \
		exit 127; \
	}
	@printf '%s\n' '#!/bin/sh' 'exec "$(VERILATOR_PATH)" "$$@"' > "$(SIMULATOR)"
	@chmod +x "$(SIMULATOR)"
	@echo "Built simulator adapter: $(CURDIR)/$(patsubst ./%,%,$(SIMULATOR))"

# Build separate one-thread and N-thread artifacts.  Verilator fixes model
# partitioning at compile time, so both are produced by compile_sim.
compile_sim: build
	@test -r "$(FILELIST)" || { \
		echo "ERROR: FILELIST is not readable: $(CURDIR)/$(FILELIST)" >&2; \
		exit 2; \
	}
	@test -n "$(TOP)" || { echo "ERROR: TOP is empty" >&2; exit 2; }
	@test "$(THREADS)" -ge 1 2>/dev/null || { \
		echo "ERROR: THREADS must be a positive integer" >&2; \
		exit 2; \
	}
	@mkdir -p "$(SINGLE_OBJ_DIR)" "$(PARALLEL_OBJ_DIR)"
	"$(SIMULATOR)" --binary -j "$(BUILD_JOBS)" \
		$(VERILATOR_FLAGS) \
		--threads 1 \
		-CFLAGS "$(VERILATOR_CFLAGS)" \
		--top-module "$(TOP)" \
		-f "$(FILELIST)" \
		--Mdir "$(SINGLE_OBJ_DIR)" \
		-o "$(abspath $(SIM_EXE))"
	"$(SIMULATOR)" --binary -j "$(BUILD_JOBS)" \
		$(VERILATOR_FLAGS) \
		--threads "$(THREADS)" \
		-CFLAGS "$(VERILATOR_CFLAGS)" \
		--top-module "$(TOP)" \
		-f "$(FILELIST)" \
		--Mdir "$(PARALLEL_OBJ_DIR)" \
		-o "$(abspath $(PARALLEL_SIM_EXE))"

run:
	@test -x "$(SIM_EXE)" || { \
		echo "ERROR: missing $(SIM_EXE); run compile_sim first" >&2; \
		exit 2; \
	}
	@rm -f tb/output.mem
	"$(abspath $(SIM_EXE))" $(RUN_ARGS)
	@test -f tb/output.mem || { \
		echo "ERROR: simulation did not generate tb/output.mem" >&2; \
		exit 3; \
	}

parallel_run:
	@test -x "$(PARALLEL_SIM_EXE)" || { \
		echo "ERROR: missing $(THREADS)-thread executable $(PARALLEL_SIM_EXE);" >&2; \
		echo "       run compile_sim THREADS=$(THREADS) first" >&2; \
		exit 2; \
	}
	@rm -f tb/output.mem
	"$(abspath $(PARALLEL_SIM_EXE))" $(PARALLEL_RUN_ARGS)
	@test -f tb/output.mem || { \
		echo "ERROR: parallel simulation did not generate tb/output.mem" >&2; \
		exit 3; \
	}

clean:
	@rm -rf "$(OBJ_ROOT)"
	@rm -f "$(SIMULATOR)" "$(SIM_EXE)" "$(PARALLEL_SIM_EXE)" tb/output.mem

.PHONY: clean build sim all

# Simulation parameters
gui            ?= 0
plusargs       ?=

# VCS build options
build_opts = \
	-kdb \
	-lca \
	-LDFLAGS -Wl,--no-as-needed \
	-full64 \
	-sverilog \
	+notimingcheck \
	-notice \
	-timescale=1ns/1ps \
	-nc \
	-l build.log \
	-top gatebanch \
	gatebanch.sv gates.sv
# In order to compile additional modules, simple add their relative paths to
# the end of build_opts

# VCS simulation options
sim_opts = \
	-l sim.log \
	-assert nopostproc \
	-assert global_finish_maxfail=1 \
	$(plusargs)

# Enable GUI
ifeq ($(gui),1)
	build_opts += -debug_acc+all+dmptf -debug_region+cell+encrypt
	sim_opts += -gui
endif

all: clean build sim

build:
	vcs $(build_opts)

sim:
	./simv $(sim_opts)


cmake_minimum_required(VERSION 3.12)
cmake_policy(SET CMP0074 NEW)
project(cmake_tracing_c)

find_package(verilator HINTS $ENV{VERILATOR_ROOT} ${VERILATOR_ROOT})
if(NOT verilator_FOUND)
    message(
        FATAL_ERROR
        "Verilator was not found. Either install it, or set the VERILATOR_ROOT environment variable"
    )
endif()

add_executable(gates gatebench-all.sv)

verilate(gates COVERAGE TRACE
  VERILATOR_ARGS -cc --main --timing --exe -o gates
  SOURCES gates.sv
)
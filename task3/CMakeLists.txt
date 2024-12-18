CMAKE_MINIMUM_REQUIRED(VERSION 3.11)
PROJECT(SVerilog)

option(COMPILER_VERILATOR "Compile with verilator, otherwise with vcs" OFF)

SET(OPTS_VERILATOR
  -cc
  --timing
  --build
  --main
  --exe)

SET(OPTS_VCS
  -full64
  -Mupdate
  -sverilog
)

SET(SIMV latches)

SET(SRC
  ${CMAKE_CURRENT_SOURCE_DIR}/srlatch_bench.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/srlatches.sv
  ${CMAKE_CURRENT_SOURCE_DIR}/util.sv
)

if(COMPILER_VERILATOR)
  SET(COMPILER verilator)
  SET(OPTS ${OPTS_VERILATOR})
  SET(WORKING_COMPILE_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
  SET(CREATE_WORK_DIRECTORY --Mdir ${CMAKE_CURRENT_BINARY_DIR})
else()
  SET(COMPILER vcs)
  SET(OPTS ${OPTS_VCS})
  SET(WORKING_COMPILE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
  SET(CREATE_WORK_DIRECTORY)
  execute_process(
    COMMAND mkdir ${CMAKE_CURRENT_BINARY_DIR}
  )
endif()

ADD_CUSTOM_TARGET(${SIMV}
  COMMAND ${COMPILER} ${OPTS} ${SRC} ${CREATE_WORK_DIRECTORY} -o ${SIMV}
  COMMENT "Compile sv files with ${COMPILER}"
  WORKING_DIRECTORY ${WORKING_COMPILE_DIRECTORY}
  DEPENDS ${SRC})

ADD_CUSTOM_TARGET(runsim_${SIMV}
  COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${SIMV}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS ${SIMV})

ADD_CUSTOM_TARGET(build-all ALL)
ADD_DEPENDENCIES(build-all runsim_${SIMV})
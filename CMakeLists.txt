cmake_minimum_required(VERSION 3.10)

# Project name
project(sdcc_parameter_test)

# Set directories
set(SRCDIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(INCDIR "${CMAKE_CURRENT_SOURCE_DIR}/include")
set(OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/bin")

# Find all source files in the source directory
file(GLOB_RECURSE PRJ_SOURCE "${SRCDIR}/*.c")

# Set compiler and tools
set(CMAKE_C_COMPILER sdcc.exe)
set(CMAKE_ASM_COMPILER sdas8051.exe)

# Set model
set(MODEL "small")

# Include directories
include_directories(
    ${INCDIR}
    "C:/Program Files/SDCC/include"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libmf/include"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libmfcrypto/include"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libaxdvk2/include"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5031/include"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5042/include"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5043/include"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5051/include"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libaxdsp/include"
)

# Library paths
link_directories(
    "C:/Program Files/SDCC/lib"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libreent/sdcc"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libmf/sdcc"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libmfcrypto/sdcc"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libaxdvk2/sdcc"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5031/sdcc"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5042/sdcc"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5043/sdcc"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libax5051/sdcc"
    "C:/Program Files (x86)/ON Semiconductor/AXSDB/libaxdsp/sdcc"
)

# Compiler and linker flags
set(COMMON_FLAGS "-mmcs51 --verbose --debug")
set(CMAKE_C_FLAGS "${COMMON_FLAGS} --model-${MODEL}")
set(CMAKE_EXE_LINKER_FLAGS "${COMMON_FLAGS} -llibmf -llibaxdvk2 --code-size 59389 --xram-size 8192 --iram-size 256")

# Create output directories
file(MAKE_DIRECTORY ${OUTPUT_DIR})

# Add executable target
add_executable(${PROJECT_NAME} ${PRJ_SOURCE})

# Set output name and directory
set_target_properties(${PROJECT_NAME} PROPERTIES
    OUTPUT_NAME "sdcc-parameter-test"
    RUNTIME_OUTPUT_DIRECTORY ${OUTPUT_DIR}
    SUFFIX ".hex"
)

# Custom clean target (similar to the Makefile's clean)
add_custom_target(clean_all
    COMMAND ${CMAKE_COMMAND} -E remove_directory "${CMAKE_BINARY_DIR}/CMakeFiles"
    COMMAND ${CMAKE_COMMAND} -E remove_directory "${OUTPUT_DIR}"
    COMMAND ${CMAKE_COMMAND} -E remove "${CMAKE_BINARY_DIR}/CMakeCache.txt"
    COMMAND ${CMAKE_COMMAND} -E remove "${CMAKE_BINARY_DIR}/cmake_install.cmake"
    COMMAND ${CMAKE_COMMAND} -E remove "${CMAKE_BINARY_DIR}/Makefile"
    COMMENT "Cleaning build files..."
)
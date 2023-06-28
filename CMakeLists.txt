cmake_minimum_required(VERSION 3.10)
project(C_apps)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

file(GLOB_RECURSE SRC_FILES "${PROJECT_SOURCE_DIR}/*.c")
add_executable(${PROJECT_NAME} ${SRC_FILES})

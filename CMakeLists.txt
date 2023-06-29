cmake_minimum_required(VERSION 3.10)
project(CPP_apps)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

file(GLOB APP_SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.c)
foreach(testsourcefile ${APP_SOURCES})
    get_filename_component(testname ${testsourcefile} NAME_WE)

    add_executable(${testname} ${testsourcefile})
endforeach(testsourcefile ${APP_SOURCES})

cmake_minimum_required(VERSION 3.6)
project(prompt_pwd)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c11")

set(SOURCE_FILES
    prompt_pwd.c)

add_executable(prompt_pwd ${SOURCE_FILES})
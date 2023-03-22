cmake_minimum_required(VERSION 3.15)

if(${CMAKE_BINARY_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
    message(FATAL_ERROR "Building on the source directory isn't allowed. Please choose another directory.")
endif()

# Gecko project
project(Gecko CXX)

include(cmake/Macros.cmake)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF) # Don't allow compiler extensions

if(NOT MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra")
else()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D_CRT_SECURE_NO_WARNINGS")
endif()

# Set the MSVC runtime library to MultiThreadedDebug if we are using the Debug configuration
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE
        Release CACHE STRING "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel." FORCE
    )
endif()

# Check git submodules
find_package(Git QUIET)
if(GIT_FOUND AND EXISTS "${CMAKE_SOURCE_DIR}/.git/")
    option(GECKO_GIT_CHECKOUT "Checkout git submodules" ON)
    if(GECKO_GIT_CHECKOUT)
        execute_process(
            COMMAND ${GIT_EXECUTABLE} submodule update --init --remote --recursive
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            RESULT_VARIABLE GIT_CHECKOUT_STATUS
        )
        if(NOT GIT_CHECKOUT_STATUS EQUAL 0)
            message(FATAL_ERROR "Failed to update submodules.")
        endif()
    endif()
endif()

if(NOT EXISTS "${CMAKE_SOURCE_DIR}/third_party/spdlog/CMakeLists.txt")
    message(FATAL_ERROR "The submodules aren't downloaded.")
endif()

# Options
option(GECKO_SHARED "Build shared libraries" OFF)

if(GECKO_SHARED)
    set(GECKO_CORE_LIBRARY_TYPE "SHARED")
else()
    set(GECKO_CORE_LIBRARY_TYPE "STATIC")
endif()

# Set the output directories
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin/")

# Set the output directories for each configuration so that it will work on Visual Studio
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_BINARY_DIR}/bin/")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/bin/")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_BINARY_DIR}/bin/")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL "${CMAKE_BINARY_DIR}/lib/")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL "${CMAKE_BINARY_DIR}/bin/")

set(spdlog_FOUND ON)
set(spdlog_LIBRARY "spdlog::spdlog")
set(spdlog_LIBRARIES ${spdlog_LIBRARY})
set(spdlog_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/third_party/spdlog/include/")
set(spdlog_INCLUDE_DIRS ${spdlog_INCLUDE_DIR})

add_subdirectory(third_party)

add_subdirectory(src)

cmake_minimum_required(VERSION 2.8)

PROJECT( fastIA )
# The version number
set(fastIA_VERSION_MAJOR 1 CACHE INTERNAL "major version")
set(fastIA_VERSION_MINOR 0 CACHE INTERNAL "minor version")

#message(STATUS "CMAKE binary dir location: ${CMAKE_BINARY_DIR}")
#message(STATUS "PROJECT binary dir location: ${PROJECT_BINARY_DIR}")

IF(NOT CMAKE_BUILD_TYPE)
  SET(CMAKE_BUILD_TYPE Release CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel."
      FORCE)
ENDIF(NOT CMAKE_BUILD_TYPE)


# Add these standard paths to the search paths for FIND_LIBRARY
# to find libraries from these locations first
if(UNIX)
    set(CMAKE_LIBRARY_PATH "${CMAKE_LIBRARY_PATH} /lib /usr/lib")
endif()


# --------------------------------------------------------------
# Indicate CMake 2.7 and above that we don't want to mix relative
#  and absolute paths in linker lib lists.
# Run "cmake --help-policy CMP0003" for more information.
# --------------------------------------------------------------
if(COMMAND cmake_policy)
    cmake_policy(SET CMP0003 NEW)
endif()

# ----------------------------------------------------------------------------
# Build static or dynamic libs?
# Default: dynamic libraries
# ----------------------------------------------------------------------------
#set(BUILD_SHARED_LIBS ON CACHE BOOL "Build shared libraries (.dll/.so) instead of static ones (.lib/.a)")

# ----------------------------------------------------------------------------
# Include profiling?
# Default: NO
# ----------------------------------------------------------------------------
set(ENABLE_PROFILING OFF CACHE BOOL "Enable profiling in the GCC compiler (Add flags: -g -pg)")

# Profiling?
if(ENABLE_PROFILING)
    set(EXTRA_C_FLAGS_RELEASE "${EXTRA_C_FLAGS_RELEASE} -pg -g")
else()
    # Remove unreferenced functions: function level linking
    if(NOT APPLE)
        set(EXTRA_C_FLAGS "${EXTRA_C_FLAGS} -ffunction-sections")
    endif()
endif()

# ----------------------------------------------------------------------------
#                       common libaries needed by all
# ----------------------------------------------------------------------------


#### OpenMP
set(USE_OPENMP OFF CACHE BOOL "Build with OpenMP support")
if (USE_OPENMP)
    include(FindOpenMP)

	 set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
	 set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
endif(USE_OPENMP)


#### for compression
find_package(ZLIB REQUIRED)
if (ZLIB_FOUND)
	include_directories(${ZLIB_INCLUDE_DIRS})
endif(ZLIB_FOUND)


# ----------------------------------------------------------------------------
#                       PROCESS SUBDIRECTORIES:
# ----------------------------------------------------------------------------
# Save libs and executables in the same place
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib CACHE PATH "Output directory for libraries" )
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR}/bin CACHE PATH "Output directory for applications" )

set(CMAKE_EXECUTABLE_SUFFIX ".exe")

# Check if the user want to build test applications
option (BUILD_TEST_APPLICATIONS "Inform whether test applications should be built" ON)
# Check if the user want to build sample applications
option (BUILD_EXAMPLE_APPLICATIONS "Inform whether sample applications should be built" ON)

add_subdirectory(src)

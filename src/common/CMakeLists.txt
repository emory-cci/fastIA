project( cci_common )

# The version number
set(cci_common_VERSION_MAJOR 1)
set(cci_common_VERSION_MINOR 0)

# Make sure the compiler can find the includes
#include_directories(${Common_SOURCE_DIR})

# Make sure the compiler can find the library in Execution Engine directory
#link_directories(${Runtime_BINARY_DIR})


set(libsrcs Logger.cpp )    




# Source files used by NScale_Common
set(libname cci_common)

# Add rule to generate execution engine, as a shared library (.so)
add_library("${libname}" SHARED ${libsrcs} )


set(Gecko_SOURCES "" CACHE INTERNAL "The source files of Gecko")

# Add source files to the Gecko_SOURCES internal cache variable
macro(gecko_add_sources srcs)
    foreach(_SRC ${ARGV})
        get_filename_component(_SRC_ABS_PATH ${_SRC} ABSOLUTE)
        set(Gecko_SOURCES "${Gecko_SOURCES};${_SRC_ABS_PATH}" CACHE INTERNAL "The source files of Gecko")
    endforeach()

    unset(_SRC)
    unset(_SRC_ABS_PATH)
endmacro()

set(Gecko_HEADERS "" CACHE INTERNAL "The header files of Gecko")

# Add header files to the Gecko_HEADERS internal cache variable
macro(gecko_add_headers hdrs)
    foreach(_HDR ${ARGV})
        get_filename_component(_HDR_ABS_PATH ${_HDR} ABSOLUTE)
        set(Gecko_HEADERS "${Gecko_HEADERS};${_HDR_ABS_PATH}" CACHE INTERNAL "The header files of Gecko")
    endforeach()

    unset(_HDR)
    unset(_HDR_ABS_PATH)
endmacro()

set(GeckoCore_SOURCES "" CACHE INTERNAL "The source files of GeckoCore")

# Add source files to the GeckoCore_SOURCES internal cache variable
macro(gecko_core_add_sources srcs)
    foreach(_SRC ${ARGV})
        get_filename_component(_SRC_ABS_PATH ${_SRC} ABSOLUTE)
        set(GeckoCore_SOURCES "${GeckoCore_SOURCES};${_SRC_ABS_PATH}" CACHE INTERNAL "The source files of GeckoCore")
    endforeach()

    unset(_SRC)
    unset(_SRC_ABS_PATH)
endmacro()

set(GeckoCore_HEADERS "" CACHE INTERNAL "The header files of GeckoCore")

# Add header files to the GeckoCore_HEADERS internal cache variable
macro(gecko_core_add_headers hdrs)
    foreach(_HDR ${ARGV})
        get_filename_component(_HDR_ABS_PATH ${_HDR} ABSOLUTE)
        set(GeckoCore_HEADERS "${GeckoCore_HEADERS};${_HDR_ABS_PATH}" CACHE INTERNAL "The header files of GeckoCore")
    endforeach()

    unset(_HDR)
    unset(_HDR_ABS_PATH)
endmacro()

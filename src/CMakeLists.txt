# GeckoCore library
add_library(GeckoCore ${GECKO_CORE_LIBRARY_TYPE} ${GeckoCore_SOURCES} ${GeckoCore_HEADERS})

# Gecko executable
add_executable(Gecko ${Gecko_SOURCES} ${Gecko_HEADERS})

target_link_libraries(Gecko PRIVATE GeckoCore)

# GeckoCore library
add_library(GeckoCore ${GECKO_CORE_LIBRARY_TYPE} ${GeckoCore_SOURCES} ${GeckoCore_HEADERS})

target_link_libraries(GeckoCore PUBLIC ${spdlog_LIBRARIES})

target_include_directories(GeckoCore PUBLIC ${spdlog_INCLUDE_DIRS})

# Gecko executable
add_executable(Gecko ${Gecko_SOURCES} ${Gecko_HEADERS})

target_link_libraries(Gecko PRIVATE GeckoCore)

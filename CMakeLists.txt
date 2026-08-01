cmake_minimum_required(VERSION 3.16)
project(NickDLL LANGUAGES C CXX)

file(GLOB_RECURSE NICKDLL_CXX_SOURCES CONFIGURE_DEPENDS "*.cpp")
set(NICKDLL_C_SOURCES tiny-json.c)

add_library(NickDLL SHARED ${NICKDLL_CXX_SOURCES} ${NICKDLL_C_SOURCES})

target_include_directories(NickDLL PRIVATE ${CMAKE_SOURCE_DIR})

target_link_options(NickDLL PRIVATE -s
  -Wl,--exclude-all-symbols
  -Wl,--gc-sections
)

target_compile_options(NickDLL PRIVATE
  -ffunction-sections -fdata-sections
  -fms-extensions -fasm-blocks
  -mmmx -msse -msse2
  $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
)

target_compile_definitions(NickDLL PRIVATE
  WIN32 $<$<CONFIG:Release>:NDEBUG> _WINDOWS _USRDLL NICKDLL_EXPORTS _MBCS
)

set_target_properties(NickDLL PROPERTIES
  OUTPUT_NAME "NickDLL"
  PREFIX ""
  SUFFIX ".dll"
)

target_link_libraries(NickDLL PRIVATE odbc32 odbccp32 -static gcc stdc++ winpthread -dynamic)
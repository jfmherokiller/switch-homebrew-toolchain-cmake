
set(DEVKITPRO "/opt/devkitpro")
set(NX 1)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(SwitchTools_nx)

set(CMAKE_SYSTEM_NAME "Generic")
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 11)

set(CMAKE_C_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc")
set(CMAKE_CXX_COMPILER "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-g++")
set(CMAKE_AR "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ar" CACHE STRING "")
set(CMAKE_RANLIB "${DEVKITPRO}/devkitA64/bin/aarch64-none-elf-gcc-ranlib" CACHE STRING "")

set(PKG_CONFIG "${DEVKITPRO}/portlibs/bin/aarch64-none-elf-pkg-config" CACHE STRING "")
set(CPPFLAGS "-D__SWITCH__ -I${DEVKITPRO}/libnx/include -I${DEVKITPRO}/portlibs/switch/include")
set(CMAKE_C_FLAGS "${CPPFLAGS} -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIC -ffunction-sections" CACHE STRING "C flags")
set(CMAKE_CXX_FLAGS "${CPPFLAGS} ${CMAKE_C_FLAGS} -fno-rtti -fno-exceptions -std=gnu++11" CACHE STRING "C++ flags")

set(CMAKE_FIND_ROOT_PATH ${DEVKITPRO}/devkitA64 ${DEVKITPRO}/libnx ${DEVKITPRO}/portlibs/switch)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
#set(CMAKE_STATIC_LINKER_FLAGS_INIT "-march=armv8-a -mtune=cortex-a57 -mtp=soft -L${DEVKITPRO}/libnx/lib -L${DEVKITPRO}/portlibs/switch/lib")
set(CMAKE_EXE_LINKER_FLAGS_INIT "-specs=${DEVKITPRO}/libnx/switch.specs -march=armv8-a -mtune=cortex-a57 -mtp=soft -fPIE -L${DEVKITPRO}/libnx/lib -L${DEVKITPRO}/portlibs/switch/lib")

set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "Shared libs not available")
set(CMAKE_INSTALL_PREFIX ${DEVKITPRO}/portlibs/switch)

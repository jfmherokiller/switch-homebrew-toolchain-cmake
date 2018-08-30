msys_to_cmake_path("$ENV{DEVKITPRO}" DEVKITPRO)
msys_to_cmake_path("$ENV{LIBTRANSISTOR_HOME}" LIBTRN)
set(NX 2)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(SwitchTools_trn)
set(CMAKE_SYSTEM_NAME "Switch")

set(TRIPLE "aarch64-none-linux-gnu")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_COMPILER "/usr/bin/clang")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++")
set(CMAKE_C_COMPILER_TARGET "${TRIPLE}")
set(CMAKE_CXX_COMPILER_TARGET "${TRIPLE}")
set(CMAKE_AR "/usr/bin/llvm-ar" CACHE STRING "")
set(CMAKE_RANLIB "/usr/bin/llvm-ranlib" CACHE STRING "")
set(CMAKE_ASM_COMPILER "/usr/bin/llvm-mc")
set(CMAKE_LINKER "/usr/bin/ld.lld")


set(SYS_INCLUDES "-isystem ${LIBTRN}/include/")
set(CPP_INCLUDES "-isystem ${LIBTRN}/include/c++/v1/")
set(LDFLAGMAIN "-Bsymbolic --shared --no-gc-sections --eh-frame-hdr --no-undefined -T ${LIBTRN}/link.T -L ${LIBTRN}/lib/")
set(LDFLAG_LIBRARY "--shared --no-gc-sections --eh-frame-hdr -T ${LIBTRN}/link.T -L ${LIBTRN}/lib/ -Bdynamic")

set(C_ARCH_FLAGS "-mtune=cortex-a53")
set(CC_FLAGS "-fPIC -fexceptions -fuse-ld=lld -fstack-protector-strong -nostdlib -nostdlibinc ${SYS_INCLUDES} -D__SWITCH__=1 -Wno-unused-command-line-argument")
set(CXX_FLAGS "${CPP_INCLUDES} ${CC_FLAGS} -stdlib=libc++ -nodefaultlibs -nostdinc++")
set(AS_FLAGS "-arch=aarch64 -triple aarch64-none-switch")

#set(PKG_CONFIG "${LIBTRN}/portlibs/bin/aarch64-none-elf-pkg-config" CACHE STRING "")


set(CMAKE_C_FLAGS "${CC_FLAGS}")
set(CMAKE_CXX_FLAGS "${CXX_FLAGS}" CACHE STRING "C++ flags")



set(LIB_DEP_COMPILER_RT_BUILTINS "${LIBTRN}/lib/libclang_rt.builtins-aarch64.a")
set(LIB_DEP_NEWLIB_LIBC "${LIBTRN}/lib/libc.a")
set(LIB_DEP_NEWLIB_LIBM "${LIBTRN}/lib/libm.a")
set(LIB_DEP_PTHREAD "${LIBTRN}/lib/libpthread.a")
set(LIB_DEP_LIBLZMA "${LIBTRN}/lib/liblzma.a")
set(LIB_DEP_LIBCXX "${LIBTRN}/lib/libc++.a")
set(LIB_DEP_LIBCXXABI "${LIBTRN}/lib/libc++abi.a")
set(LIB_DEP_LIBUNWIND "${LIBTRN}/lib/libunwind.a")
set(CXX_LIB_DEPS "${LIB_DEP_LIBCXX} ${LIB_DEP_LIBCXXABI} ${LIB_DEP_LIBUNWIND}")
set(LIBTRANSISTOR_COMMON_LIB_DEPS "${LIB_DEP_NEWLIB_LIBC} ${LIB_DEP_NEWLIB_LIBM} ${LIB_DEP_COMPILER_RT_BUILTINS} ${LIB_DEP_PTHREAD} ${LIB_DEP_LIBLZMA} ${CXX_LIB_DEPS} ${LIBTRN}/link.T")
set(LIBTRANSISTOR_COMMON_LIBS "${LIBTRANSISTOR_COMMON_LIB_DEPS} # for older Makefiles")
set(LIBTRANSISTOR_NRO_DEP "${LIBTRN}/lib/libtransistor.nro.a")
set(LIBTRANSISTOR_NSO_DEP "${LIBTRN}/lib/libtransistor.nso.a")
set(LIBTRANSISTOR_NRO_LIB "${LIBTRANSISTOR_NRO_DEP}")
set(LIBTRANSISTOR_NSO_LIB "${LIBTRANSISTOR_NSO_DEP}")
set(LIBTRANSISTOR_NRO_DEPS "${LIBTRN}/lib/libtransistor.nro.a ${LIBTRANSISTOR_COMMON_LIB_DEPS}")
set(LIBTRANSISTOR_NSO_DEPS "${LIBTRN}/lib/libtransistor.nso.a ${LIBTRANSISTOR_COMMON_LIB_DEPS}")


set(LIBTRANSISTOR_EXECUTABLE_LDFLAGS "-Bstatic -lc -lm -lclang_rt.builtins-aarch64 -lpthread -llzma -lc++ -lc++abi -lunwind -Bdynamic")
set(LIBTRANSISTOR_NRO_LDFLAGS "--whole-archive -ltransistor.nro --no-whole-archive ${LIBTRANSISTOR_EXECUTABLE_LDFLAGS}")
set(LIBTRANSISTOR_NSO_LDFLAGS "--whole-archive -ltransistor.nso --no-whole-archive ${LIBTRANSISTOR_EXECUTABLE_LDFLAGS}")
set(LIBTRANSISTOR_LIB_LDFLAGS "-lc -lclang_rt.builtins-aarch64 -lc++ -lc++abi -lunwind")

set(CMAKE_EXE_LINKER_FLAGS_INIT "${LIBTRANSISTOR_NRO_LDFLAGS}")
set(CMAKE_SHARED_LINKER_FLAGS_INIT "${LIBRARY_LINK}")


set(NRO_COMMAND "python3 ${LIBTRN}/tools/elf2nxo.py <TARGET> <TARGET>.nro nro")
set(CMAKE_C_COMPILE_OBJECT "<CMAKE_C_COMPILER> ${C_ARCH_FLAGS} <DEFINES> <FLAGS> -o <OBJECT> -c <SOURCE>")
set(CMAKE_CXX_COMPILE_OBJECT "<CMAKE_CXX_COMPILER> ${C_ARCH_FLAGS} <DEFINES> <FLAGS> -o <OBJECT> -c <SOURCE>")
set(CMAKE_C_LINK_EXECUTABLE "${CMAKE_LINKER} ${LDFLAGMAIN} <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_LINKER} ${LDFLAGMAIN} <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_LINK_EXECUTABLE "${CMAKE_LINKER} ${LDFLAGMAIN} <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_C_CREATE_SHARED_LIBRARY "${CMAKE_LINKER} ${LDFLAG_LIBRARY} <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_CXX_CREATE_SHARED_LIBRARY "${CMAKE_LINKER} ${LDFLAG_LIBRARY} <CMAKE_CXX_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_C_CREATE_STATIC_LIBRARY "<CMAKE_AR> rcs <LINK_FLAGS> <TARGET> <OBJECTS>")
set(CMAKE_CXX_CREATE_STATIC_LIBRARY "<CMAKE_AR> rcs <LINK_FLAGS> <TARGET> <OBJECTS>")

set(CMAKE_FIND_ROOT_PATH ${LIBTRN})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

#SET_PROPERTY(GLOBAL PROPERTY BUILD_SHARED_LIBS TRUE)
set(CMAKE_INSTALL_PREFIX ${DEVKITPRO})

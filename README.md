# switch-homebrew-toolchain-cmake
Set of files to allow switch homebrew development using cmake

The base i used for both toolchain files came from https://github.com/carstene1ns/physfs-switch/blob/master/Toolchain.cmake

I then used https://github.com/Lectem/3ds-cmake/blob/master/cmake/Tools3DS.cmake to make the basic tool finder code for libnx

I do not know if it will work with any setup so ill share my current setup so you can see an example.
![directory layout](https://i.imgur.com/OguGhpB.png?1 "how I have my directory layed out")


Special notes: 

The toolchain files have it builtin where the projects can distiguish between libnx and libtransistor.

Is its done by comparing the value of the NX variable.
A value of 1 means libnx.
A value of 2 means libtransistor.

Both toolchains have a add_nro_target function which uses that toolchains utilities to generate an nro from the compiled elf.

---
date: '2020-05-15'
title: Installation
---

Installation
===

`NetCDF95` is written in Fortran 2003 so you need a Fortran 2003
compiler on your machine. Moreover, you need to have the [NetCDF Fortran
library](https://www.unidata.ucar.edu/downloads/netcdf/index.jsp)
installed using the same Fortran compiler than the one you are going to
use for `NetCDF95`. (Note that the NetCDF Fortran library itself
requires prior installation of the NetCDF C library.)

Get [NetCDF95 from Github](https://github.com/lguez/NetCDF95). As the
Git repository contains a submodule, the easiest way is to type:

		git clone --recurse-submodules https://github.com/lguez/NetCDF95.git

If you prefer to download a ZIP file then you will also have to
download the [cmake subdirectory](https://github.com/lguez/cmake).

Installation with CMake
---

This is the recommended way.

Dependencies: you must first install [CMake](https://cmake.org/download)
(version ≥ 3.16).

1.  Type:

        cd /path/to/NetCDF95
        mkdir build
        cd build
            

2.  Choose the installation directory `CMAKE_INSTALL_PREFIX` and type
    the command below with your choice after `-DCMAKE_INSTALL_PREFIX=`
    (enter an absolute path). For example, you could choose
    `-DCMAKE_INSTALL_PREFIX=~/.local`.

        cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=~/.local
            

3.  Type:

        make install
            

Installation directly with make
---

This is the (old) less automated way, not recommended.

1.  If you want to use a Fortran 2003 compiler other than GNU Fortran
    then, in the file GNUmakefile, locate the line:

        FC = gfortran

    Replace gfortran by the command name for your compiler. Remember
    that you need the NetCDF Fortran library installed with the chosen
    compiler. If you have version 4.2 or later of the NetCDF Fortran
    library installed, then the program `nf-config` should have been
    installed with the library. This program will tell you the compiler
    you need to use with your NetCDF Fortran library. Just type:

        nf-config --fc

2.  If the NetCDF Fortran library installed with the chosen compiler is
    not in standard locations, you have to provide the locations. In
    GNUmakefile, locate the line defining the variable
    netcdf\_include\_dir :

        netcdf_include_dir = /usr/include

    Replace `/usr/include` by the path to the compiled NetCDF module
    interfaces (usually `netcdf.mod` and `typesizes.mod`). Note that
    NetCDF95 does not need `netcdf.inc`. If you have the command
    `nf-config`, type:

        nf-config --includedir

    to find out the path you need.

3.  If you want to cross-compile, you may need to choose the archiver
    program, by setting the variable `AR`. For example, cross-compiling
    for a NEC SX machine:

        export AR=sxar

4.  Optionally, you may choose additional compiler options by adding to
    the variable `FFLAGS`. For example, you could modify the
    optimization option `-O2`.
5.  The makefile is written for GNU make. The command invoking GNU make
    may be `make` or `gmake` (or `sxgmake` if you want to cross-compile
    for NEC SX). So, for example, type:

        make

6.  With most compilers, `libnetcdf95.a` and `netcdf95.mod` are the only
    files you will need, but with some compilers, you may need all the
    `.mod` files produced by the compilation of NetCDF95. (Keep them all
    to be on the safe side, or experiment with your compiler to see what
    you need to keep (see [usage](usage.md)).) You
    can trash everything else (`.o` files, Fortran source files, etc.)
    if you want.
# Installation

## Dependencies

- [CMake](https://cmake.org/download) (version ≥ 3.16)[^1].

-  A Fortran compiler. `NetCDF95` is written in Fortran (2003).

- The [NetCDF Fortran
  library](https://www.unidata.ucar.edu/downloads/netcdf/index.jsp)
  installed using the same Fortran compiler than the one you are going
  to use for `NetCDF95`. (Note that the NetCDF Fortran library itself
  requires prior installation of the NetCDF C library.)

## Instructions

1. Get [NetCDF95 from Github](https://github.com/lguez/NetCDF95). As
   the Git repository contains a submodule, the easiest way is to
   type:

		git clone --recurse-submodules https://github.com/lguez/NetCDF95.git

	If you prefer to download a ZIP file then you will also have to
	download the [cmake subdirectory](https://github.com/lguez/cmake).

2.  Create a build subdirectory in the NetCDF95 directory you have
    just downloaded:

        cd the-directory-you-have-just-downloaded
        mkdir build
        cd build

3.  Decide in which directory you want to install NetCDF95 after
    compilation and type the command below with your choice after
    `-DCMAKE_INSTALL_PREFIX=` (enter an absolute path). For example:

        cmake .. -DCMAKE_INSTALL_PREFIX=~/.local

4.  Type:

        make install

You do not need to keep the downloaded directory (nor the build
directory) after installation.

## Advanced instructions

- You can choose any name and any location for the build
  directory. You have to refer to the source directory when you run
  cmake from the build directory:

		mkdir /wherever/any/name
		cd /wherever/any/name
		cmake /where/I/downloaded/NetCDF95 -DCMAKE_INSTALL_PREFIX=~/.local

- NetCDF95 assumes that the Fortran default character kind is the same
  as the C character kind (the official NetCDF-Fortran interface makes
  the same assumption). You can test this by running the command
  `ctest` in the build directory. If this test fails then the
  procedures `nf95_inq_grpname`, `nf95_inq_grpname_full` and
  `nf95_inq_grp_full_ncid` are not reliable.

[^1]: On Mac OS, after downloading the application from the CMake web
    site, run it, then click on "How to Install For Command Line Use"
    in the Tools menu.

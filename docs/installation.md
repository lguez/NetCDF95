# Installation

## Dependencies

- [CMake](https://cmake.org/download) (version ≥ 3.16)[^1].

- The [NetCDF C
  library](https://docs.unidata.ucar.edu/nug/current/getting_and_building_netcdf.html).

- The [NetCDF-Fortran
  library](https://www.unidata.ucar.edu/downloads/netcdf/index.jsp).

- The Fortran compiler that was used to compile your installed
  NetCDF-Fortran library.

Under Ubuntu or Linux Mint, you can install all these dependencies
with the following command:

	apt install libnetcdff-dev gfortran cmake

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

You do not need to keep the downloaded directory NetCDF95 (nor the
build directory) after installation.

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

- You do not have to install. You can just use the compiled library in
  the build directory. So you do not have to specify the option
  `-DCMAKE_INSTALL_PREFIX=` and you can just type make instead of
  `make install`.

- You can compile with debugging options by adding the option
  `-DCMAKE_BUILD_TYPE=Debug` to the command cmake.

## Troubleshooting

- If your installation of NetCDF or NetCDF-Fortran is in a non-standard
location, and CMake does not find it, then re-run cmake setting the
variable `CMAKE_PREFIX_PATH` to the directory containing it. CMake
will then search `${CMAKE_PREFIX_PATH}/lib`,
`${CMAKE_PREFIX_PATH}/include`, etc. For example:

		cmake . -DCMAKE_PREFIX_PATH:PATH=/path/to/my/favorite/installation

- If you have several Fortran or C compilers on your machine, it is
  possible that CMake does not choose the ones you want. Note that when
  you run cmake, it prints lines telling which compilers it is going
  to use. For example :

		-- The Fortran compiler identification is GNU 11.3.0
		-- The C compiler identification is GNU 11.3.0

	So if you want other compilers, remove everything in the build
	directory and run cmake again setting the variables FC and CC to the
	compilers you want. For example:

		rm -r * # in the build directory!
		FC=ifort CC=icc cmake .. -DCMAKE_INSTALL_PREFIX=~/.local

[^1]: On Mac OS, after downloading the application from the CMake web
    site, run it, then click on "How to Install For Command Line Use"
    in the Tools menu.

# Usage

## In the source code of the consumer program

The name of the module that you must use in your Fortran program is
`netcdf95`. For example:

```
use netcdf95, only: nf95_open, nf95_nowrite, nf95_inq_varid, nf95_gw_var, &
	nf95_close
```

## Building the consumer program with CMake

If you build your program using NetCDF95 with CMake, then download
both
[`FindNetCDF_Fortran.cmake`](https://github.com/lguez/cmake/blob/master/FindNetCDF_Fortran.cmake)
and
[`FindnetCDF.cmake`](https://github.com/lguez/cmake/blob/master/FindnetCDF.cmake)
into the directory of your consumer program and add the following
lines to the file `CMakeLists.txt` for your program:

```
find_package(NetCDF_Fortran REQUIRED)
find_package(NetCDF95 CONFIG REQUIRED)
target_link_libraries(my_program PRIVATE NetCDF95::netcdf95
  NetCDF_Fortran::netcdff)
```

(replace `my_program` by the name of your target).

## Building the consumer program without CMake

If you do not build the consumer program with CMake, take into account
that your program will require `netcdf95.mod` (and possibly other
`.mod` files produced by compilation of NetCDF95) at compile time and
`libnetcdf95.a` at link time. Note that NetCDF95 uses the Fortran 90
NetCDF interface, so you must keep the options you would use for
direct access to the Fortran 90 NetCDF interface.

For most compilers, the options you will need to add are:

    -I$netcdf95_inc_dir

at compile time and:

    -L$netcdf95_lib_dir -L$netcdf90_lib_dir -lnetcdf95 -lnetcdff -lnetcdf

at link time, where `$netcdf95_inc_dir` is the directory where you put
`.mod` files produced by compilation of NetCDF95, `$netcdf95_lib_dir`
is the directory where you put `libnetcdf95.a` and `$netcdf90_lib_dir`
is the directory where the Fortran 90 NetCDF interface is
installed.

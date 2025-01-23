# Library version

(functionality change)

```
subroutine nf95_inq_libvers
```

The corresponding function
[`nf90_inq_libvers`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90_datasets.html#f90-get-netcdf-library-version-nf90_inq_libvers)
in the Fortran 90 NetCDF interface surprisingly returns the version of
the linked C library. `nf95_inq_libvers` is a subroutine, not a
function, and it prints both the version of NetCDF95 and the version
of the linked C library.

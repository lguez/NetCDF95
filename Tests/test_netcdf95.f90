program test_netcdf95

  ! This is a program in Fortran 95.

  use netcdf, only: nf90_inq_libvers
  use netcdf95, only: nf95_open, nf95_close, nf95_nowrite

  IMPLICIT none

  integer ncid

  !-----------------------------------------------------------------------

  print *, "NetCDF library version: ", trim(nf90_inq_libvers())
  call nf95_open("plouf.nc", nf95_nowrite, ncid)
  call nf95_close(ncid)

END program test_netcdf95

program test_netcdf95

  use netcdf95, only: nf95_open, nf95_close, nf95_nowrite, nf95_inq_libvers

  IMPLICIT none

  integer ncid

  !-----------------------------------------------------------------------

  call nf95_inq_libvers
  call nf95_open("plouf.nc", nf95_nowrite, ncid)
  call nf95_close(ncid)

END program test_netcdf95

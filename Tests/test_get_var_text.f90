program test_get_var_text

  use netcdf, only: nf90_nowrite
  use netcdf95, only: nf95_open, nf95_close, nf95_get_var, nf95_inq_varid

  implicit none

  integer ncid, varid
  character c

  !------------------------------------------------

  call nf95_open("test_char.nc", nf90_nowrite, ncid)
  call nf95_inq_varid(ncid, "aa", varid)
  call nf95_get_var(ncid, varid, c)
  call nf95_close(ncid)
  print *, 'c = "', c, '"'

end program test_get_var_text

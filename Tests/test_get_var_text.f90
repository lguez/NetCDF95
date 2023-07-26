program test_get_var_text

  use netcdf95, only: nf95_open, nf95_close, nf95_get_var, nf95_inq_varid, &
       nf95_nowrite

  implicit none

  integer ncid, varid
  character c

  !------------------------------------------------

  call nf95_open("test_char.nc", nf95_nowrite, ncid)

  ! Read from a scalar variable:
  call nf95_inq_varid(ncid, "aa", varid)
  call nf95_get_var(ncid, varid, c)
  print *, 'c = "', c, '"'

  ! Read from a one-dimensional variable:
  call nf95_inq_varid(ncid, "x", varid)
  call nf95_get_var(ncid, varid, c, start = [2])
  print *, 'c = "', c, '"'

  ! Read from a two-dimensional variable:
  call nf95_inq_varid(ncid, "bidim_array", varid)
  call nf95_get_var(ncid, varid, c, start = [3,2])
  print *, 'c = "', c, '"'

  call nf95_close(ncid)

end program test_get_var_text

program test_get_missing_2

  use netcdf95, only: nf95_open, nf95_close, nf95_get_missing, nf95_inq_varid, &
       nf95_nowrite

  implicit none

  integer ncid, varid
  character missing

  !-------------------------------------------------------------------

  call nf95_open("test_char.nc", nf95_nowrite, ncid)

  ! This should fail:
  call nf95_inq_varid(ncid, "z", varid)
  call nf95_get_missing(ncid, varid, missing)
  print *, 'missing z = "', missing, '"'

  call nf95_close(ncid)

end program test_get_missing_2

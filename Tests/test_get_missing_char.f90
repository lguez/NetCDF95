program test_get_missing_char

  use netcdf, only: nf90_nowrite, nf90_global
  use netcdf95, only: nf95_open, nf95_close, nf95_get_missing, nf95_inq_varid

  implicit none

  integer ncid, varid
  character missing

  !-------------------------------------------------------------------

  call nf95_open("test_char.nc", nf90_nowrite, ncid)

  ! Global:
  call nf95_get_missing(ncid, nf90_global, missing)
  print *, 'missing nf90_global = "', missing, '"'
  print *, "iachar(missing) = ", iachar(missing)

  ! x:
  call nf95_inq_varid(ncid, "x", varid)
  call nf95_get_missing(ncid, varid, missing)
  print *, 'missing x = "', missing, '"'

  ! y:
  call nf95_inq_varid(ncid, "y", varid)
  call nf95_get_missing(ncid, varid, missing)
  print *, 'missing y = "', missing, '"'
  
  ! z, this should fail:
!!$  call nf95_inq_varid(ncid, "z", varid)
!!$  call nf95_get_missing(ncid, varid, missing)
!!$  print *, 'missing z = "', missing, '"'
  
  call nf95_close(ncid)

end program test_get_missing_char

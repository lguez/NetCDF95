program test_char
  
  use netcdf
  use netcdf95, only: handle_err, nf95_close

  implicit none

  integer status
  integer                           :: ncid, oceanStrLenID, oceanId
  integer, parameter                :: MaxOceanNameLen = 20
  character(len = maxoceannamelen):: ocean

  !----------------------------------------------------------------------
  
  status = nf90_create("foo.nc", nf90_noclobber, ncid)
  if(status /= nf90_noerr) call handle_err("test_char", status)
  status = nf90_def_dim(ncid, "oceanStrLen", maxoceannamelen, oceanstrlenid)
  if(status /= nf90_noerr) call handle_err("test_char", status)
  status = nf90_def_var(ncid, "ocean", nf90_char, (/ oceanstrlenid /), oceanid)
  if(status /= nf90_noerr) call handle_err("test_char", status)
  ! Leave define mode, which prefills netCDF variables with fill values
  status = nf90_enddef(ncid)
  if (status /= nf90_noerr) call handle_err("test_char", status)
  ! Note that this assignment adds blank fill
  ocean = "Pacific"
  ! Using trim removes trailing blanks, prefill provides null
  ! termination, so C programs can later get intended string.
  status = nf90_put_var(ncid, oceanid, trim(ocean))
  if(status /= nf90_noerr) call handle_err("test_char", status)
  call nf95_close(ncid)

end program test_char

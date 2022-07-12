program test_put_var_char
  
  use netcdf, only: nf90_noclobber, nf90_put_var, nf90_char
  use netcdf95, only: nf95_abort, nf95_close, nf95_create, nf95_def_dim, &
       nf95_def_var, nf95_enddef, nf95_noerr

  implicit none

  integer status, ncid, oceanStrLenID, oceanId
  integer, parameter:: MaxOceanNameLen = 20
  character(len = maxoceannamelen) ocean

  !----------------------------------------------------------------------
  
  call nf95_create("foo.nc", nf90_noclobber, ncid)
  call nf95_def_dim(ncid, "oceanStrLen", maxoceannamelen, oceanstrlenid)
  call nf95_def_var(ncid, "ocean", nf90_char, (/ oceanstrlenid /), oceanid)
  ! Leave define mode, which prefills netCDF variables with fill values
  call nf95_enddef(ncid)
  ! Note that this assignment adds blank fill
  ocean = "Pacific"
  ! Using trim removes trailing blanks, prefill provides null
  ! termination, so C programs can later get intended string.
  status = nf90_put_var(ncid, oceanid, trim(ocean))
  if(status /= nf95_noerr) call nf95_abort("test_char", status)
  call nf95_close(ncid)

end program test_put_var_char

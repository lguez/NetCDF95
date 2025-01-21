program test_get_missing

  use netcdf95, only: nf95_open, nf95_close, nf95_get_missing, nf95_inq_varid, &
       nf95_nowrite, nf95_global, nf95_get_var

  implicit none

  integer ncid, varid
  character missing
  real missing_real, adt_real(5)
  double precision adt(5)

  !-------------------------------------------------------------------

  call nf95_open("test_char.nc", nf95_nowrite, ncid)

  ! Global:
  call nf95_get_missing(ncid, nf95_global, missing)
  print *, 'missing nf95_global = "', missing, '"'
  print *, "iachar(missing) = ", iachar(missing)

  ! x:
  call nf95_inq_varid(ncid, "x", varid)
  call nf95_get_missing(ncid, varid, missing)
  print *, 'missing x = "', missing, '"'

  ! y:
  call nf95_inq_varid(ncid, "y", varid)
  call nf95_get_missing(ncid, varid, missing)
  print *, 'missing y = "', missing, '"'
  
  call nf95_close(ncid)
  call nf95_open("histhf.nc", nf95_nowrite, ncid)
  call nf95_inq_varid(ncid, "temp", varid)
  call nf95_get_missing(ncid, varid, missing_real)
  print *, 'missing temp = ', missing_real
  call nf95_close(ncid)
  call nf95_open("plouf.nc", nf95_nowrite, ncid)
  call nf95_inq_varid(ncid, "adt", varid)
  call nf95_get_missing(ncid, varid, missing_real)
  call nf95_get_var(ncid, varid, adt)
  print *, "adt = ", adt

  ! Second value is not recognized as missing:
  print *, "adt == missing:", adt == missing_real
  print *, "adt == dle(missing):", adt == dble(missing_real)

  call nf95_get_var(ncid, varid, adt_real)
  print *, "adt_real = ", adt_real
  ! Fourth value is wrongly identified as missing:
  print *, "adt_real == missing:", adt_real == missing_real

  call nf95_close(ncid)

end program test_get_missing

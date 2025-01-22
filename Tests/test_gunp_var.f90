program test_gunp_var

  use netcdf95, only: nf95_gunp_var, nf95_open, nf95_close, nf95_nowrite, &
       nf95_inq_varid

  implicit none

  integer ncid, varid
  real adt(5)
  logical was_packed

  !-------------------------------------------------------------------------

  call nf95_open("adt.nc", nf95_nowrite, ncid)
  call nf95_inq_varid(ncid, "adt", varid)
  call nf95_gunp_var(ncid, varid, adt, was_packed, start = [271, 1, 1], &
       count_nc = [5, 1, 1])
  print *, "adt = ", adt
  print *, "was_packed = ", was_packed
  call nf95_close(ncid)
  
end program test_gunp_var

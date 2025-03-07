program test_find_coord

  use netcdf95, only: nf95_find_coord, nf95_open, nf95_nowrite, nf95_close, &
       NF95_MAX_NAME

  implicit none

  integer ncid, dimid, varid, ncerr
  character(len = NF95_MAX_NAME) name

  !------------------------------------------------------------------------

  call nf95_open("adt.nc", nf95_nowrite, ncid)
  call nf95_find_coord(ncid, name, dimid, varid, std_name = "longitude")
  print *, "name = ", trim(name)
  print *, "dimid = ", dimid
  print *, "varid = ", varid
  call nf95_find_coord(ncid, name, dimid, varid, std_name = "plev", &
       ncerr = ncerr)
  print *, "name = ", trim(name)
  print *, "dimid = ", dimid
  print *, "varid = ", varid
  print *, "ncerr = ", ncerr
  call nf95_close(ncid)

end program test_find_coord

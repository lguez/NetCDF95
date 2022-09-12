program test_create_single

  use netcdf95, only: nf95_create_single, coord_def, nf95_enddef, nf95_close

  implicit none

  integer ncid, varid, varid_coord(1)
  type(coord_def) lon_def

  !-----------------------------------------------------------------------

  ! Do not use a structure constructor to circumvent GFortran bug 106918:
  lon_def%name = "longitude"
  lon_def%nclen = 10
  lon_def%attr_name = ["units"]
  lon_def%attr_val = ["degrees_east"]

  call nf95_create_single("plouf", [lon_def], ncid, varid, varid_coord)
  call nf95_enddef(ncid)
  call nf95_close(ncid)

end program test_create_single

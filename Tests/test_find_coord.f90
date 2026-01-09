program test_find_coord

  use netcdf95, only: nf95_find_coord, nf95_open, nf95_nowrite, nf95_close, &
       NF95_MAX_NAME

  implicit none

  integer ncid, dimid, varid, ncerr
  character(len = NF95_MAX_NAME) name
  character(len = 9):: std_name = ""
  logical:: recovery = .false.
  namelist /main_nml/ std_name, recovery

  !------------------------------------------------------------------------

  print *, "Enter namelist main_nml:"
  read(unit = *, nml = main_nml)
  call nf95_open("adt.nc", nf95_nowrite, ncid)

  if (recovery) then
     call nf95_find_coord(ncid, name, dimid, varid, std_name, ncerr)
     print *, "ncerr = ", ncerr
  else
     call nf95_find_coord(ncid, name, dimid, varid, std_name)
  end if

  print *, "name = ", trim(name)
  print *, "dimid = ", dimid
  print *, "varid = ", varid
  call nf95_close(ncid)

end program test_find_coord

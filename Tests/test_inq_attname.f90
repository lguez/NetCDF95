program test_inq_attname

  use netcdf95, only: nf95_inq_attname, nf95_open, nf95_nowrite, nf95_close, &
       NF95_GLOBAL

  implicit none

  integer ncid
  character(len = :), allocatable:: name

  !--------------------------------------------------------------------

  call nf95_open("histhf.nc", nf95_nowrite, ncid)
  call nf95_inq_attname(ncid, NF95_GLOBAL, attnum = 1, name = name)
  print *, 'name of attribute 1: "', name, '"'
  call nf95_inq_attname(ncid, NF95_GLOBAL, attnum = 12, name = name)
  print *, 'name of attribute 12: "', name, '"'
  call nf95_close(ncid)

end program test_inq_attname

program test_get_att_text

  use netcdf95, only: nf95_get_att, nf95_open, nf95_nowrite, nf95_close, &
       NF95_GLOBAL

  implicit none

  integer ncid
  character(len = 65) values

  !--------------------------------------------------------------------

  call nf95_open("histhf.nc", nf95_nowrite, ncid)
  call nf95_get_att(ncid, NF95_GLOBAL, name = "CDO", values= values)
  print *, 'values: "', values, '"'
  call nf95_close(ncid)

end program test_get_att_text

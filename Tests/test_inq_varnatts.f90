program test_inq_varnatts

  use netcdf95, only: nf95_inq_varnatts, nf95_open, nf95_nowrite, &
       nf95_inq_varid, nf95_close, nf95_inq_grp_full_ncid, NF95_GLOBAL

  implicit none

  integer ncid, varid, natts, grp_ncid

  !------------------------------------------------------------------

  call nf95_open("aerosol_optics.nc", nf95_nowrite, ncid)
  call nf95_inq_grp_full_ncid(ncid, "Hydrophilic/SW_bands", grp_ncid)
  call nf95_inq_varid(grp_ncid, "wavenumber", varid)
  call nf95_inq_varnatts(grp_ncid, varid, natts)
  print *, "natts for wavenumber:", natts
  call nf95_inq_varid(grp_ncid, "wavenumber_bounds", varid)
  call nf95_inq_varnatts(grp_ncid, varid, natts)
  print *, "natts for wavenumber_bounds:", natts
  call nf95_close(ncid)
  call nf95_open("histhf.nc", nf95_nowrite, ncid)
  call nf95_inq_varnatts(ncid, NF95_GLOBAL, natts)
  print *, "natts for global:", natts
  call nf95_close(ncid)

end program test_inq_varnatts

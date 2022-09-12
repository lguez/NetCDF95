program test_inq_file_ncid

  use netcdf95, only: nf95_inq_file_ncid, nf95_open, nf95_nowrite, nf95_close, &
       nf95_inq_grp_full_ncid

  implicit none

  integer ncid_file, ncid, grpid

  !---------------------------------------------------------------------------

  call nf95_open("aerosol_optics.nc", nf95_nowrite, ncid)
  print *, "ncid = ", ncid
  call nf95_inq_grp_full_ncid(ncid, "/Hydrophilic/SW_bands", grpid)
  call nf95_inq_file_ncid(ncid_file, grpid)
  print *, "ncid_file = ", ncid_file
  call nf95_close(ncid)

end program test_inq_file_ncid

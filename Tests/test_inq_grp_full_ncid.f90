program test_inq_grp_full_ncid

  use netcdf, only: nf90_nowrite, nf90_noerr, nf90_strerror
  use netcdf95, only: nf95_open, nf95_close, nf95_inq_grp_full_ncid, &
       nf95_inq_grpname_full

  implicit none

  integer ncid, grpid, grpid_2, ncerr
  character(len = :), allocatable:: name

  !-------------------------------------------------------------------

  call nf95_open("aerosol_optics.nc", nf90_nowrite, ncid)

  print *, "Absolute from root..."
  call nf95_inq_grp_full_ncid(ncid, "/Hydrophilic/SW_bands", grpid)
  call nf95_inq_grpname_full(grpid, name)
  print *, "name = ", name

  print *, "Relative from root..."
  call nf95_inq_grp_full_ncid(ncid, "Hydrophilic/SW_bands", grpid)
  call nf95_inq_grpname_full(grpid, name)
  print *, "name = ", name

  print *, "Relative ambiguous from root..."

  call nf95_inq_grp_full_ncid(ncid, "SW_bands", grpid, ncerr)

  if (ncerr /= nf90_noerr) then
     print *, trim(nf90_strerror(ncerr))
  else
     call nf95_inq_grpname_full(grpid, name)
     print *, "name = ", name
  end if

  print *, "Absolute from subgroup..."

  call nf95_inq_grp_full_ncid(grpid, "/Hydrophilic/SW_bands", grpid_2, ncerr)

  if (ncerr /= nf90_noerr) then
     print *, trim(nf90_strerror(ncerr))
  else
     call nf95_inq_grpname_full(grpid_2, name)
     print *, "name = ", name
  end if

  print *, "Relative from subgroup..."
  call nf95_inq_grp_full_ncid(ncid, "Hydrophilic", grpid)
  call nf95_inq_grp_full_ncid(grpid, "SW_bands", grpid_2, ncerr)

  if (ncerr /= nf90_noerr) then
     print *, trim(nf90_strerror(ncerr))
  else
     call nf95_inq_grpname_full(grpid_2, name)
     print *, "name = ", name
  end if

  print *, "Bad relative from subgroup..."

  call nf95_inq_grp_full_ncid(grpid, "Hydrophilic/SW_bands", grpid_2, ncerr)

  if (ncerr /= nf90_noerr) then
     print *, trim(nf90_strerror(ncerr))
  else
     call nf95_inq_grpname_full(grpid_2, name)
     print *, "name = ", name
  end if

  call nf95_close(ncid)

end program test_inq_grp_full_ncid

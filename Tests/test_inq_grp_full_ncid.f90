program test_inq_grp_full_ncid

  use netcdf, only: nf90_strerror
  use netcdf95, only: nf95_open, nf95_close, nf95_inq_grp_full_ncid, &
       nf95_inq_grpname_full, nf95_nowrite, nf95_noerr

  implicit none

  integer ncid, grpid, grpid_2, ncerr
  character(len = :), allocatable:: name

  !-------------------------------------------------------------------

  call nf95_open("aerosol_optics.nc", nf95_nowrite, ncid)

  print *, "Absolute from root should work..."
  call nf95_inq_grp_full_ncid(ncid, "/Hydrophilic/SW_bands", grpid)
  call nf95_inq_grpname_full(grpid, name)
  print *, "name = ", name

  print *
  print *, "Relative from root should work..."
  call nf95_inq_grp_full_ncid(ncid, "Hydrophilic/SW_bands", grpid)
  call nf95_inq_grpname_full(grpid, name)
  print *, "name = ", name

  print *
  print *, "Relative to subgroup (hence ambiguous) from root should not work..."

  call nf95_inq_grp_full_ncid(ncid, "SW_bands", grpid, ncerr)

  if (ncerr /= nf95_noerr) then
     print *, trim(nf90_strerror(ncerr))
  else
     call nf95_inq_grpname_full(grpid, name)
     print *, "name = ", name
  end if

  print *
  print *, "Absolute from subgroup should not work..."

  call nf95_inq_grp_full_ncid(grpid, "/Hydrophilic/SW_bands", grpid_2, ncerr)

  if (ncerr /= nf95_noerr) then
     print *, trim(nf90_strerror(ncerr))
  else
     call nf95_inq_grpname_full(grpid_2, name)
     print *, "name = ", name
  end if

  print *
  print *, "Relative to subgroup from subgroup should work..."
  call nf95_inq_grp_full_ncid(ncid, "Hydrophilic", grpid)
  call nf95_inq_grp_full_ncid(grpid, "SW_bands", grpid_2, ncerr)

  if (ncerr /= nf95_noerr) then
     print *, trim(nf90_strerror(ncerr))
  else
     call nf95_inq_grpname_full(grpid_2, name)
     print *, "name = ", name
  end if

  print *
  print *, "Bad relative from subgroup should not work, of course..."

  call nf95_inq_grp_full_ncid(grpid, "Hydrophilic/SW_bands", grpid_2, ncerr)

  if (ncerr /= nf95_noerr) then
     print *, trim(nf90_strerror(ncerr))
  else
     call nf95_inq_grpname_full(grpid_2, name)
     print *, "name = ", name
  end if

  call nf95_close(ncid)

end program test_inq_grp_full_ncid

program test_inq_grps

  use netcdf, only: nf90_nowrite
  use netcdf95, only: nf95_open, nf95_inq_grps, nf95_close, &
       nf95_inq_grpname_full, nf95_inq_grp_full_ncid

  implicit none

  integer ncid, i, grpid
  integer, allocatable:: ncids(:)
  character(len = :), allocatable:: name

  !-------------------------------------------------------------------

  call nf95_open("aerosol_optics.nc", nf90_nowrite, ncid)
  call nf95_inq_grps(ncid, ncids)
  print *, "ncids = ", ncids

  do i = 1, size(ncids)
     call nf95_inq_grpname_full(ncids(i), name)
     print *, 'name = "', name, '"'
  end do

  call nf95_inq_grp_full_ncid(ncid, "Hydrophilic/SW_bands", grpid)
  call nf95_inq_grps(grpid, ncids)
  print *, "ncids = ", ncids

  call nf95_close(ncid)

end program test_inq_grps

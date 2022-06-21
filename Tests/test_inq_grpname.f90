program test_inq_grpname

  use netcdf, only: nf90_nowrite
  use netcdf95, only: nf95_open, nf95_close, nf95_inq_grpname, nf95_inq_grps

  implicit none

  integer ncid, i
  character(len = :), allocatable:: name
  integer, allocatable:: ncids(:), grpids(:)

  !-------------------------------------------------------------------

  call nf95_open("aerosol_optics.nc", nf90_nowrite, ncid)
  call nf95_inq_grpname(ncid, name)
  print *, "name = ", name
  call nf95_inq_grps(ncid, ncids)

  do i = 1, size(ncids)
     call nf95_inq_grpname(ncids(i), name)
     print *, "name = ", name
  end do

  call nf95_inq_grps(ncids(1), grpids)

  do i = 1, size(grpids)
     call nf95_inq_grpname(grpids(i), name)
     print *, "name = ", name
  end do

  call nf95_close(ncid)

end program test_inq_grpname

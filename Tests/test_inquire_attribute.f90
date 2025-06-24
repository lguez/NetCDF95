program test_inquire_attribute

  use jumble, only: get_command_arg_dyn
  use netcdf95, only: nf95_inquire_attribute, nf95_open, nf95_nowrite, &
       nf95_close

  implicit none

  character(len = :), allocatable:: fname, att_name
  integer ncid, varid, xtype, nclen
  character(len = *), parameter:: usage &
       = "test_inquire_attribute FILE-NAME VARID ATT-NAME"

  !-------------------------------------------------------------------------

  call get_command_arg_dyn(1, fname, usage)
  call get_command_arg_dyn(2, varid, usage)
  call get_command_arg_dyn(3, att_name, usage)
  call nf95_open(fname, nf95_nowrite, ncid)
  call nf95_inquire_attribute(ncid, varid, att_name, xtype, nclen)
  call nf95_close(ncid)
  print *, "xtype =", xtype
  print *, "nclen =", nclen

end program test_inquire_attribute

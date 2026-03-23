program test_gunp_var_2

  use, intrinsic:: iso_fortran_env, only: error_unit

  use jumble, only: get_command_arg_dyn
  use netcdf95, only: nf95_gunp_var, nf95_open, nf95_close, nf95_nowrite, &
       nf95_inq_varid

  implicit none

  integer ncid, varid
  real var_4d(2, 2, 2, 2), var_3d(2, 2, 2), var_2d(2, 2), var_1d(2)
  logical was_packed
  character(len =:), allocatable:: file, varname

  !-------------------------------------------------------------------------

  if (command_argument_count() /= 2) then
     write(error_unit, fmt = *) "Required arguments: file variable-name"
     stop 1
  end if

  call get_command_arg_dyn(1, file)
  call get_command_arg_dyn(2, varname)
  call nf95_open(file, nf95_nowrite, ncid)
  call nf95_inq_varid(ncid, varname, varid)
  call nf95_gunp_var(ncid, varid, var_4d, was_packed)
  print *, "var_4d = ", var_4d
  print *, "was_packed = ", was_packed
  call nf95_gunp_var(ncid, varid, var_3d)
  print *, "var_3d = ", var_3d
  call nf95_gunp_var(ncid, varid, var_2d)
  print *, "var_2d = ", var_2d
  call nf95_gunp_var(ncid, varid, var_1d)
  print *, "var_1d = ", var_1d
  call nf95_close(ncid)

end program test_gunp_var_2

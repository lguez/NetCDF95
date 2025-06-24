program test_get_att_text

  use jumble, only: get_command_arg_dyn
  use netcdf95, only: nf95_get_att, nf95_open, nf95_nowrite, nf95_close, &
       nf95_noerr, nf95_strerror

  implicit none

  integer ncid, ncerr
  logical:: recovery = .true.
  integer:: varid = 0, len_values = 65
  character(len = :), allocatable:: values, fname, att_name
  character(len = *), parameter:: usage = "test_get_att_text FILE-NAME ATT-NAME"
  namelist /main_nml/ VARID, len_values, recovery

  !--------------------------------------------------------------------

  call get_command_arg_dyn(1, fname, usage)
  call get_command_arg_dyn(2, att_name, usage)
  print *, "Enter main_nml:"
  read(unit = *, nml = main_nml)
  call nf95_open(fname, nf95_nowrite, ncid)
  allocate(character(len = len_values):: values)

  if (recovery) then
     call nf95_get_att(ncid, varid, att_name, values, ncerr)

     if (ncerr == nf95_noerr) then
        print *, 'values: "', values, '"'
     else
        print *, "ncerr =", ncerr
        print *, nf95_strerror(ncerr)
     end if
  else
     call nf95_get_att(ncid, varid, att_name, values)
     print *, 'values: "', values, '"'
  end if

  call nf95_close(ncid)

end program test_get_att_text

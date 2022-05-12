program test_handle_err

  use netcdf95, only: handle_err

  implicit none

  !----------------------------------------------------------

  call handle_err(message = "plouf", ncerr = 1)
  
end program test_handle_err

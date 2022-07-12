program test_abort

  use netcdf95, only: nf95_abort

  implicit none

  !----------------------------------------------------------

  call nf95_abort(message = "plouf", ncerr = 1)

end program test_abort

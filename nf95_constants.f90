module nf95_constants

  use nc_constants, only: NC_NOERR, NC_ENOGRP

  implicit none

  Integer, Parameter:: Nf95_NOERR = NC_NOERR
  Integer, Parameter:: Nf95_ENOGRP = NC_ENOGRP
  integer, parameter:: nf95_nowrite = 0, nf95_clobber   = 0, nf95_global = 0
  integer, parameter:: nf95_unlimited = 0
  real, parameter:: nf95_fill_real = 9.9692099683868690e+36
  integer, parameter:: nf95_max_name = 256, nf95_float = 5, nf95_double = 6

  private NC_NOERR, NC_ENOGRP

end module nf95_constants

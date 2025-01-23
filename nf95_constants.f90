module nf95_constants

  use nc_constants, only: NC_NOERR, NC_ENOGRP
  use type_sizes, only: EightByteReal, TwoByteInt, onebyteint

  implicit none

  Integer, Parameter:: Nf95_NOERR = NC_NOERR
  Integer, Parameter:: Nf95_ENOGRP = NC_ENOGRP
  integer, parameter:: nf95_global = 0
  integer, parameter:: nf95_unlimited = 0

  ! External netcdf data types:
  integer, parameter:: nf95_byte = 1, nf95_char = 2, nf95_short  = 3, &
       nf95_int = 4, nf95_float = 5, nf95_double = 6
  character(len=*), parameter:: type_name(6) = [character(len = 6):: "byte", &
       "char", "short", "int", "float", "double"]

  ! Mode flags for opening and creating a netcdf dataset:
  integer, parameter:: nf95_nowrite = 0, nf95_clobber = 0
  integer, parameter:: nf95_write = 1, nf95_noclobber = 4

  ! Implementation limits:

  integer, parameter:: nf95_max_name = 256
  ! maximum number of characters for the length of a name in the
  ! classic netCDF model

  integer, parameter:: nf95_max_var_dims = 1024

  ! Default fill values:
  integer, parameter:: nf95_fill_int = - 2147483647
  integer(TwoByteInt), parameter:: nf95_fill_short = -32767
  integer(onebyteint), parameter:: nf95_fill_byte  = -127
  real, parameter:: nf95_fill_real = 9.9692099683868690e+36
  real(EightByteReal), parameter:: nf95_fill_double &
       = 9.9692099683868690e36_EightByteReal
  character, parameter:: nf95_fill_char = achar(0)

  private NC_NOERR, NC_ENOGRP, EightByteReal, TwoByteInt

end module nf95_constants

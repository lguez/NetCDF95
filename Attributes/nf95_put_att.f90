module nf95_put_att_m

  use, intrinsic:: iso_fortran_env, only: error_unit

  use netcdf, only: nf90_put_att
  use nf95_abort_m, only: nf95_abort
  use nf95_constants, only: nf95_noerr

  implicit none

  interface nf95_put_att
     module procedure nf95_put_att_text, nf95_put_att_one_FourByteInt, &
          nf95_put_att_one_FourByteReal
  end interface nf95_put_att

  private
  public nf95_put_att

contains

  subroutine nf95_put_att_text(ncid, varid, name, values, ncerr)

    integer, intent(in) :: ncid, varid
    character(len = *), intent(in) :: name
    character(len = *), intent(in) :: values
    integer, intent(out), optional:: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt
    character(len=*), parameter:: procedure_name = "nf95_put_att_text"

    !-------------------

    include "nf95_put_att.h"

  end subroutine nf95_put_att_text

  !************************************

  subroutine nf95_put_att_one_FourByteInt(ncid, varid, name, values, ncerr)

    use type_sizes, only: FourByteInt

    integer, intent(in) :: ncid, varid
    character(len = *), intent(in) :: name
    integer(kind = FourByteInt), intent(in) :: values
    integer, intent(out), optional:: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt
    character(len=*), parameter:: procedure_name &
         = "nf95_put_att_one_FourByteInt"

    !-------------------

    include "nf95_put_att.h"

  end subroutine nf95_put_att_one_FourByteInt

  !************************************

  subroutine nf95_put_att_one_FourByteReal(ncid, varid, name, values, ncerr)

    use type_sizes, only: FourByteReal

    integer, intent(in) :: ncid, varid
    character(len = *), intent(in) :: name
    real(kind = FourByteReal), intent(in) :: values
    integer, intent(out), optional:: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt
    character(len=*), parameter:: procedure_name &
         = "nf95_put_att_one_FourByteReal"

    !-------------------

    include "nf95_put_att.h"

  end subroutine nf95_put_att_one_FourByteReal

end module nf95_put_att_m

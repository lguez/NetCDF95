module nf95_get_missing_m

  use, intrinsic:: iso_fortran_env, only: error_unit

  use nf95_abort_m, only: nf95_abort
  use nf95_constants, only: nf95_noerr
  use nf95_get_att_m, only: nf95_get_att

  implicit none

  interface nf95_get_missing
     module procedure nf95_get_missing_real, nf95_get_missing_dble, &
          nf95_get_missing_short_int, nf95_get_missing_int, &
          nf95_get_missing_char, nf95_get_missing_byte_int
  end interface nf95_get_missing

  private
  public nf95_get_missing

contains

  subroutine nf95_get_missing_real(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_REAL

    integer, intent(in)::  ncid, varid
    real, intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr_1, ncerr_2
    real missing_1

    !-------------------------------------------------------------------

    include "nf95_get_missing.h"

  end subroutine nf95_get_missing_real

  !**************************************************************************

  subroutine nf95_get_missing_dble(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_double

    integer, intent(in)::  ncid, varid
    double precision, intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr_1, ncerr_2
    double precision missing_1

    !-------------------------------------------------------------------

    include "nf95_get_missing.h"

  end subroutine nf95_get_missing_dble

  !**************************************************************************

  subroutine nf95_get_missing_short_int(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_short
    use type_sizes, only: TwoByteInt

    integer, intent(in)::  ncid, varid
    integer(kind = TwoByteInt), intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr_1, ncerr_2
    integer(kind = TwoByteInt) missing_1

    !-------------------------------------------------------------------

    include "nf95_get_missing.h"

  end subroutine nf95_get_missing_short_int

  !**************************************************************************

  subroutine nf95_get_missing_int(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_INT

    integer, intent(in)::  ncid, varid
    integer, intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr_1, ncerr_2
    integer missing_1

    !-------------------------------------------------------------------

    include "nf95_get_missing.h"

  end subroutine nf95_get_missing_int

  !**************************************************************************

  subroutine nf95_get_missing_char(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_char

    integer, intent(in)::  ncid, varid

    character, intent(out):: missing
    ! Missing or fill value. Note that the missing_value attribute for
    ! a NetCDF character variable should be a single character

    ! Local:
    integer ncerr_1, ncerr_2
    character missing_1

    !-------------------------------------------------------------------

    include "nf95_get_missing.h"

  end subroutine nf95_get_missing_char

  !**************************************************************************

  subroutine nf95_get_missing_byte_int(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_byte
    use type_sizes, only: oneByteInt

    integer, intent(in)::  ncid, varid
    integer(kind = oneByteInt), intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr_1, ncerr_2
    integer(kind = oneByteInt) missing_1

    !-------------------------------------------------------------------

    include "nf95_get_missing.h"

  end subroutine nf95_get_missing_byte_int

end module nf95_get_missing_m

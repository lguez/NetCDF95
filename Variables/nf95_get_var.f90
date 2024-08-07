module nf95_get_var_m

  use netcdf, only: nf90_get_var
  
  use check_start_count_m, only: check_start_count
  use nf95_abort_m, only: nf95_abort
  use nf95_constants, only: nf95_noerr
  use nf95_get_missing_m, only: nf95_get_missing

  implicit none

  interface nf95_get_var
     module procedure nf95_get_var_FourByteReal, nf95_get_var_FourByteInt, &
          nf95_get_var_EightByteReal, nf95_get_var_text, &
          nf95_get_var_1D_FourByteReal, nf95_get_var_1D_FourByteInt, &
          nf95_get_var_1D_EightByteReal, nf95_get_var_2D_FourByteReal, &
          nf95_get_var_2D_EightByteReal, nf95_get_var_2D_twoByteInt, &
          nf95_get_var_2D_FourByteInt, nf95_get_var_3D_FourByteInt, &
          nf95_get_var_3D_FourByteReal, nf95_get_var_3D_EightByteReal, &
          nf95_get_var_4D_FourByteReal, nf95_get_var_4D_EightByteReal, &
          nf95_get_var_5D_FourByteReal, nf95_get_var_5D_EightByteReal
     ! The interface of nf95_get_var_FourByteInt is distinguishable
     ! from the interface of nf95_get_var_[1-4]D_FourByteInt because
     ! of the rank of `values`.
  end interface

  private
  public nf95_get_var

  integer ncerr_not_opt

contains

  subroutine nf95_get_var_FourByteReal(ncid, varid, values, start, &
       new_missing, ncerr)

    use type_sizes, only: FourByteReal

    integer, intent(in):: ncid, varid
    real(kind = FourByteReal), intent(out):: values
    integer, dimension(:), optional, intent(in):: start
    real(kind = FourByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = "nf95_get_var_FourByteReal"
    real(kind = FourByteReal) missing

    !-------------------

    include "nf95_get_var_scalar.h"

  end subroutine nf95_get_var_FourByteReal

  !***********************

  subroutine nf95_get_var_FourByteInt(ncid, varid, values, start, new_missing, &
       ncerr)

    use type_sizes, only: FourByteInt

    integer, intent(in):: ncid, varid
    integer(kind = FourByteInt), intent(out):: values
    integer, dimension(:), optional, intent(in):: start
    integer(kind = FourByteInt), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = "nf95_get_var_FourByteInt"
    integer(kind = FourByteInt) missing
    
    !-------------------

    include "nf95_get_var_scalar.h"

  end subroutine nf95_get_var_FourByteInt

  !***********************

  subroutine nf95_get_var_EightByteReal(ncid, varid, values, start, &
       new_missing, ncerr)

    use type_sizes, only: EightByteReal

    integer, intent(in):: ncid, varid
    real(kind = EightByteReal), intent(out):: values
    integer, dimension(:), optional, intent(in):: start
    real(kind = EightByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = "nf95_get_var_EightByteReal"
    real(kind = EightByteReal) missing

    !-------------------

    include "nf95_get_var_scalar.h"

  end subroutine nf95_get_var_EightByteReal

  !***********************

  subroutine nf95_get_var_text(ncid, varid, values, start, new_missing, ncerr)

    integer, intent(in):: ncid, varid
    character, intent(out):: values
    integer, dimension(:), optional, intent(in):: start
    character, optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = "nf95_get_var_text"
    character missing

    !-------------------

    include "nf95_get_var_scalar.h"

  end subroutine nf95_get_var_text

  !***********************

  subroutine nf95_get_var_1D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: FourByteReal

    integer,                         intent(in):: ncid, varid
    real(kind = FourByteReal), intent(out):: values(:)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = FourByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_1D_FourByteReal"
    integer, parameter:: rank_values = 1
    real(kind = FourByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_1D_FourByteReal

  !***********************

  subroutine nf95_get_var_1D_FourByteInt(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: FourByteInt

    integer, intent(in):: ncid, varid
    integer(kind = FourByteInt), intent(out):: values(:)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer(kind = FourByteInt), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_1D_FourByteInt"
    integer, parameter:: rank_values = 1
    integer(kind = FourByteInt) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_1D_FourByteInt

  !***********************

  subroutine nf95_get_var_1D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: eightByteReal

    integer,                         intent(in):: ncid, varid
    real(kind = EightByteReal),     intent(out):: values(:)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = EightByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_1D_EightByteReal"
    integer, parameter:: rank_values = 1
    real(kind = EightByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_1D_EightByteReal

  !***********************

  subroutine nf95_get_var_2D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: FourByteReal

    integer,                         intent(in):: ncid, varid
    real(kind = FourByteReal), intent(out):: values(:, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = FourByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_2D_FourByteReal"
    integer, parameter:: rank_values = 2
    real(kind = FourByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_2D_FourByteReal

  !***********************

  subroutine nf95_get_var_2D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: EightByteReal

    integer,                         intent(in):: ncid, varid
    real(kind = EightByteReal), intent(out):: values(:, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = EightByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_2D_EightByteReal"
    integer, parameter:: rank_values = 2
    real(kind = EightByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_2D_EightByteReal

  !***********************

  subroutine nf95_get_var_2D_TwoByteInt(ncid, varid, values, start, count_nc, &
       stride, map, new_missing, ncerr)

    use type_sizes, only: TwoByteInt

    integer, intent(in):: ncid, varid
    integer(kind = TwoByteInt), intent(out):: values(:, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer(kind = TwoByteInt), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = "nf95_get_var_2D_TwoByteInt"
    integer, parameter:: rank_values = 2
    integer(kind = TwoByteInt) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_2D_TwoByteInt

  !***********************

  subroutine nf95_get_var_2D_FourByteInt(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: FourByteInt

    integer, intent(in):: ncid, varid
    integer(kind = FourByteInt), intent(out):: values(:, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer(kind = FourByteInt), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_2D_FourByteInt"
    integer, parameter:: rank_values = 2
    integer(kind = FourByteInt) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_2D_FourByteInt

  !***********************

  subroutine nf95_get_var_3D_FourByteInt(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: FourByteInt

    integer, intent(in):: ncid, varid
    integer(kind = FourByteInt), intent(out):: values(:, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer(kind = FourByteInt), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_3D_FourByteInt"
    integer, parameter:: rank_values = 3
    integer(kind = FourByteInt) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_3D_FourByteInt

  !***********************

  subroutine nf95_get_var_3D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: FourByteReal

    integer,                         intent(in):: ncid, varid
    real(kind = FourByteReal), intent(out):: values(:, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = FourByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_3D_FourByteReal"
    integer, parameter:: rank_values = 3
    real(kind = FourByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_3D_FourByteReal

  !***********************

  subroutine nf95_get_var_3D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: eightByteReal

    integer,                         intent(in):: ncid, varid
    real(kind = EightByteReal),     intent(out):: values(:, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = EightByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_3D_EightByteReal"
    integer, parameter:: rank_values = 3
    real(kind = EightByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_3D_EightByteReal

  !***********************

  subroutine nf95_get_var_4D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: FourByteReal

    integer,                         intent(in):: ncid, varid
    real(kind = FourByteReal), intent(out):: values(:, :, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = FourByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_4D_FourByteReal"
    integer, parameter:: rank_values = 4
    real(kind = FourByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_4D_FourByteReal

  !***********************

  subroutine nf95_get_var_4D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: EightByteReal

    integer, intent(in):: ncid, varid
    real(kind = EightByteReal), intent(out):: values(:, :, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = EightByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_4D_EightByteReal"
    integer, parameter:: rank_values = 4
    real(kind = EightByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_4D_EightByteReal

  !***********************

  subroutine nf95_get_var_5D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: FourByteReal

    integer, intent(in):: ncid, varid
    real(kind = FourByteReal), intent(out):: values(:, :, :, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = FourByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_5D_FourByteReal"
    integer, parameter:: rank_values = 5
    real(kind = FourByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_5D_FourByteReal

  !***********************

  subroutine nf95_get_var_5D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, new_missing, ncerr)

    use type_sizes, only: EightByteReal

    integer, intent(in):: ncid, varid
    real(kind = EightByteReal), intent(out):: values(:, :, :, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    real(kind = EightByteReal), optional, intent(in):: new_missing
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_5D_EightByteReal"
    integer, parameter:: rank_values = 5
    real(kind = EightByteReal) missing

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_5D_EightByteReal

end module nf95_get_var_m

module nf95_get_var_m

  use netcdf, only: nf90_get_var
  use handle_err_m, only: handle_err
  use check_start_count_m, only: check_start_count

  implicit none

  interface nf95_get_var
     module procedure nf95_get_var_FourByteReal, nf95_get_var_FourByteInt, &
          nf95_get_var_1D_FourByteReal, nf95_get_var_1D_FourByteInt, &
          nf95_get_var_1D_EightByteReal, nf95_get_var_2D_FourByteReal, &
          nf95_get_var_2D_EightByteReal, nf95_get_var_2D_FourByteInt, &
          nf95_get_var_3D_FourByteInt, nf95_get_var_3D_FourByteReal, &
          nf95_get_var_3D_EightByteReal, nf95_get_var_4D_FourByteReal, &
          nf95_get_var_4D_EightByteReal, nf95_get_var_5D_FourByteReal, &
          nf95_get_var_5D_EightByteReal
  end interface

  private
  public nf95_get_var

  integer ncerr_not_opt

contains

  subroutine nf95_get_var_FourByteReal(ncid, varid, values, start, ncerr)

    use typesizes, only: FourByteReal

    integer, intent(in) :: ncid, varid
    real(kind = FourByteReal), intent(out) :: values
    integer, dimension(:), optional, intent(in) :: start
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = "nf95_get_var_FourByteReal"

    !-------------------

    include "nf95_get_var_scalar.h"

  end subroutine nf95_get_var_FourByteReal

  !***********************

  subroutine nf95_get_var_FourByteInt(ncid, varid, values, start, ncerr)

    use typesizes, only: FourByteInt

    integer, intent(in) :: ncid, varid
    integer(kind = FourByteInt), intent(out) :: values
    integer, dimension(:), optional, intent(in) :: start
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = "nf95_get_var_FourByteInt"

    !-------------------

    include "nf95_get_var_scalar.h"

  end subroutine nf95_get_var_FourByteInt

  !***********************

  subroutine nf95_get_var_1D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: FourByteReal

    integer,                         intent(in) :: ncid, varid
    real(kind = FourByteReal), intent(out) :: values(:)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_1D_FourByteReal"
    integer, parameter:: rank_values = 1

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_1D_FourByteReal

  !***********************

  subroutine nf95_get_var_1D_FourByteInt(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: FourByteInt

    integer,                         intent(in) :: ncid, varid
    integer(kind = FourByteInt), intent(out) :: values(:)
    integer, dimension(:), optional, intent(in) :: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_1D_FourByteInt"
    integer, parameter:: rank_values = 1

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_1D_FourByteInt

  !***********************

  subroutine nf95_get_var_1D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: eightByteReal

    integer,                         intent(in) :: ncid, varid
    real (kind = EightByteReal),     intent(out) :: values(:)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_1D_EightByteReal"
    integer, parameter:: rank_values = 1

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_1D_EightByteReal

  !***********************

  subroutine nf95_get_var_2D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: FourByteReal

    integer,                         intent(in) :: ncid, varid
    real (kind = FourByteReal), intent(out) :: values(:, :)
    integer, dimension(:), optional, intent(in) :: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_2D_FourByteReal"
    integer, parameter:: rank_values = 2

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_2D_FourByteReal

  !***********************

  subroutine nf95_get_var_2D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: EightByteReal

    integer,                         intent(in) :: ncid, varid
    real (kind = EightByteReal), intent(out) :: values(:, :)
    integer, dimension(:), optional, intent(in) :: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_2D_EightByteReal"
    integer, parameter:: rank_values = 2

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_2D_EightByteReal

  !***********************

  subroutine nf95_get_var_2D_FourByteInt(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: FourByteInt

    integer, intent(in):: ncid, varid
    integer(kind = FourByteInt), intent(out):: values(:, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_2D_FourByteInt"
    integer, parameter:: rank_values = 2

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_2D_FourByteInt

  !***********************

  subroutine nf95_get_var_3D_FourByteInt(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: FourByteInt

    integer, intent(in):: ncid, varid
    integer(kind = FourByteInt), intent(out):: values(:, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_3D_FourByteInt"
    integer, parameter:: rank_values = 3

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_3D_FourByteInt

  !***********************

  subroutine nf95_get_var_3D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: FourByteReal

    integer,                         intent(in) :: ncid, varid
    real (kind = FourByteReal), intent(out) :: values(:, :, :)
    integer, dimension(:), optional, intent(in) :: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_3D_FourByteReal"
    integer, parameter:: rank_values = 3

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_3D_FourByteReal

  !***********************

  subroutine nf95_get_var_3D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: eightByteReal

    integer,                         intent(in) :: ncid, varid
    real (kind = EightByteReal),     intent(out) :: values(:, :, :)
    integer, dimension(:), optional, intent(in) :: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_3D_EightByteReal"
    integer, parameter:: rank_values = 3

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_3D_EightByteReal

  !***********************

  subroutine nf95_get_var_4D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: FourByteReal

    integer,                         intent(in) :: ncid, varid
    real (kind = FourByteReal), intent(out) :: values(:, :, :, :)
    integer, dimension(:), optional, intent(in) :: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_4D_FourByteReal"
    integer, parameter:: rank_values = 4

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_4D_FourByteReal

  !***********************

  subroutine nf95_get_var_4D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: EightByteReal

    integer, intent(in):: ncid, varid
    real(kind = EightByteReal), intent(out):: values(:, :, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_4D_EightByteReal"
    integer, parameter:: rank_values = 4

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_4D_EightByteReal

  !***********************

  subroutine nf95_get_var_5D_FourByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: FourByteReal

    integer, intent(in):: ncid, varid
    real(kind = FourByteReal), intent(out):: values(:, :, :, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_5D_FourByteReal"
    integer, parameter:: rank_values = 5

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_5D_FourByteReal

  !***********************

  subroutine nf95_get_var_5D_EightByteReal(ncid, varid, values, start, &
       count_nc, stride, map, ncerr)

    use typesizes, only: EightByteReal

    integer, intent(in):: ncid, varid
    real(kind = EightByteReal), intent(out):: values(:, :, :, :, :)
    integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
    integer, intent(out), optional:: ncerr

    ! Local:
    character(len=*), parameter:: procedure_name = &
         "nf95_get_var_5D_EightByteReal"
    integer, parameter:: rank_values = 5

    !-------------------

    include "nf95_get_var_array.h"

  end subroutine nf95_get_var_5D_EightByteReal

end module nf95_get_var_m

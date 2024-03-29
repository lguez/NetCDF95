module nf95_get_missing_m

  use netcdf, only: nf90_noerr
  use nf95_get_att_m, only: nf95_get_att

  implicit none

  interface nf95_get_missing
     module procedure nf95_get_missing_real, nf95_get_missing_dble, &
          nf95_get_missing_short_int, nf95_get_missing_int, &
          nf95_get_missing_char
  end interface nf95_get_missing

  private
  public nf95_get_missing

contains

  subroutine nf95_get_missing_real(ncid, varid, missing)

    use netcdf, only: NF90_FILL_REAL

    integer, intent(in)::  ncid, varid
    real, intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf90_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf90_noerr) missing = NF90_FILL_REAL
    end if

  end subroutine nf95_get_missing_real

  !**************************************************************************

  subroutine nf95_get_missing_dble(ncid, varid, missing)

    use netcdf, only: NF90_FILL_double

    integer, intent(in)::  ncid, varid
    double precision, intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf90_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf90_noerr) missing = NF90_FILL_double
    end if

  end subroutine nf95_get_missing_dble

  !**************************************************************************

  subroutine nf95_get_missing_short_int(ncid, varid, missing)

    use netcdf, only: NF90_FILL_short
    use typesizes, only: TwoByteInt

    integer, intent(in)::  ncid, varid
    integer(kind = TwoByteInt), intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf90_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf90_noerr) missing = NF90_FILL_short
    end if

  end subroutine nf95_get_missing_short_int

  !**************************************************************************

  subroutine nf95_get_missing_int(ncid, varid, missing)

    use netcdf, only: NF90_FILL_INT

    integer, intent(in)::  ncid, varid
    integer, intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf90_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf90_noerr) missing = NF90_FILL_INT
    end if

  end subroutine nf95_get_missing_int

  !**************************************************************************

  subroutine nf95_get_missing_char(ncid, varid, missing)

    use netcdf, only: NF90_FILL_char

    integer, intent(in)::  ncid, varid

    character, intent(out):: missing
    ! Missing or fill value. Note that the missing_value attribute for
    ! a NetCDF character variable should be a single character

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)
    if (ncerr /= nf90_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf90_noerr) missing = NF90_FILL_char
    end if

  end subroutine nf95_get_missing_char

end module nf95_get_missing_m

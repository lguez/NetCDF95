module nf95_get_missing_m

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
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf95_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf95_noerr) missing = NF95_FILL_TYPE
    end if

  end subroutine nf95_get_missing_real

  !**************************************************************************

  subroutine nf95_get_missing_dble(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_double

    integer, intent(in)::  ncid, varid
    double precision, intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf95_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf95_noerr) missing = nf95_fill_type
    end if

  end subroutine nf95_get_missing_dble

  !**************************************************************************

  subroutine nf95_get_missing_short_int(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_short
    use type_sizes, only: TwoByteInt

    integer, intent(in)::  ncid, varid
    integer(kind = TwoByteInt), intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf95_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf95_noerr) missing = nf95_fill_type
    end if

  end subroutine nf95_get_missing_short_int

  !**************************************************************************

  subroutine nf95_get_missing_int(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_INT

    integer, intent(in)::  ncid, varid
    integer, intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf95_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf95_noerr) missing = NF95_FILL_TYPE
    end if

  end subroutine nf95_get_missing_int

  !**************************************************************************

  subroutine nf95_get_missing_char(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_char

    integer, intent(in)::  ncid, varid

    character, intent(out):: missing
    ! Missing or fill value. Note that the missing_value attribute for
    ! a NetCDF character variable should be a single character

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf95_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf95_noerr) missing = nf95_fill_type
    end if

  end subroutine nf95_get_missing_char

  !**************************************************************************

  subroutine nf95_get_missing_byte_int(ncid, varid, missing)

    use nf95_constants, only: nf95_fill_type => NF95_FILL_byte
    use type_sizes, only: oneByteInt

    integer, intent(in)::  ncid, varid
    integer(kind = oneByteInt), intent(out):: missing ! missing or fill value

    ! Local:
    integer ncerr

    !-------------------------------------------------------------------

    call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
         ncerr = ncerr)

    if (ncerr /= nf95_noerr) then
       call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
            ncerr = ncerr)
       if (ncerr /= nf95_noerr) missing = nf95_fill_type
    end if

  end subroutine nf95_get_missing_byte_int

end module nf95_get_missing_m

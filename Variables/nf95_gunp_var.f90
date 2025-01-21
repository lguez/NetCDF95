module nf95_gunp_var_m

  use, intrinsic:: iso_fortran_env

  use nf95_constants, only: NF95_BYTE, NF95_SHORT, NF95_INT, nf95_noerr
  use nf95_get_att_m, only: nf95_get_att
  use nf95_get_missing_m, only: nf95_get_missing
  use nf95_get_var_m, only: nf95_get_var
  use nf95_inquire_variable_m, only: nf95_inquire_variable
  use type_sizes, only: OneByteInt, TwoByteInt

  implicit none

  interface nf95_gunp_var
     ! Get unpacked variable
     module procedure nf95_gunp_var_real_1d, nf95_gunp_var_real_2d, &
          nf95_gunp_var_real_3d, nf95_gunp_var_dble
  end interface nf95_gunp_var

  private
  public nf95_gunp_var

contains

  subroutine nf95_gunp_var_real_1d(ncid, varid, values, start, count_nc, &
       new_missing)

    use nf95_constants, only: NF95_FILL_REAL

    integer, intent(in):: ncid, varid
    real, intent(out):: values(:)
    integer, optional, intent(in):: start(:), count_nc(:)
    real, optional, intent(in):: new_missing

    ! Local:
    integer xtype, missing_packed
    integer(OneByteInt) missing_byte
    integer(TwoByteInt) missing_short
    integer ncerr_scale, ncerr_offset

    integer, allocatable:: packed_values(:)
    ! we use an allocatable array instead of an automatic array
    ! because we do not know if the array is going to be useful

    real scale_factor, add_offset, missing

    !------------------------------------------------------------------------

    call nf95_get_att(ncid, varid, "scale_factor", scale_factor, ncerr_scale)
    call nf95_get_att(ncid, varid, "add_offset", add_offset, ncerr_offset)

    if (ncerr_scale == nf95_noerr .or. ncerr_offset == nf95_noerr) then
       call nf95_inquire_variable(ncid, varid, xtype = xtype)

       if (all(xtype /= [NF95_BYTE, NF95_SHORT, NF95_INT])) then
          write(error_unit, fmt = *) "nf95_gunp_var_real_1d: type of packed " &
               // "variable must be integer (any kind)"
          stop 1
       end if

       allocate(packed_values(size(values)))
       call nf95_get_var(ncid, varid, packed_values, start, count_nc)

       ! We cannot just call nf95_get_missing with argument
       ! missing_packed because we want to get the right nf95_fill_*
       ! value if there is no missing_value or _FillValue
       ! attribute. Note that the type of the missing_value or
       ! _FillValue attribute, if any, must be xtype, according to CF
       ! convention.
       select case(xtype)
       case(NF95_BYTE)
          call nf95_get_missing(ncid, varid, missing_byte)
          missing_packed = missing_byte
       case(NF95_SHORT)
          call nf95_get_missing(ncid, varid, missing_SHORT)
          missing_packed = missing_SHORT
       case(NF95_INT)
          call nf95_get_missing(ncid, varid, missing_packed)
       end select

       if (present(new_missing)) then
          missing = new_missing
       else
          missing = NF95_FILL_REAL
       end if

       if (ncerr_scale /= nf95_noerr) scale_factor = 1.
       if (ncerr_offset /= nf95_noerr) add_offset = 0.

       where(packed_values == missing_packed)
          values = missing
       elsewhere
          values = packed_values * scale_factor + add_offset
       end where
    else
       call nf95_get_var(ncid, varid, values, start, count_nc, &
            new_missing = new_missing)
    end if

  end subroutine nf95_gunp_var_real_1d

  !**************************************************************************

  subroutine nf95_gunp_var_real_2d(ncid, varid, values, start, count_nc, &
       new_missing)

    use nf95_constants, only: NF95_FILL_REAL

    integer, intent(in):: ncid, varid
    real, intent(out):: values(:, :)
    integer, optional, intent(in):: start(:), count_nc(:)
    real, optional, intent(in):: new_missing

    ! Local:
    integer xtype, missing_packed
    integer(OneByteInt) missing_byte
    integer(TwoByteInt) missing_short
    integer ncerr_scale, ncerr_offset

    integer, allocatable:: packed_values(:, :)
    ! we use an allocatable array instead of an automatic array
    ! because we do not know if the array is going to be useful

    real scale_factor, add_offset, missing

    !------------------------------------------------------------------------

    call nf95_get_att(ncid, varid, "scale_factor", scale_factor, ncerr_scale)
    call nf95_get_att(ncid, varid, "add_offset", add_offset, ncerr_offset)

    if (ncerr_scale == nf95_noerr .or. ncerr_offset == nf95_noerr) then
       call nf95_inquire_variable(ncid, varid, xtype = xtype)

       if (all(xtype /= [NF95_BYTE, NF95_SHORT, NF95_INT])) then
          write(error_unit, fmt = *) "nf95_gunp_var_real_2d: type of packed " &
               // "variable must be integer (any kind)"
          stop 1
       end if

       allocate(packed_values(size(values, 1), size(values, 2)))
       call nf95_get_var(ncid, varid, packed_values, start, count_nc)

       ! We cannot just call nf95_get_missing with argument
       ! missing_packed because we want to get the right nf95_fill_*
       ! value if there is no missing_value or _FillValue
       ! attribute. Note that the type of the missing_value or
       ! _FillValue attribute, if any, must be xtype, according to CF
       ! convention.
       select case(xtype)
       case(NF95_BYTE)
          call nf95_get_missing(ncid, varid, missing_byte)
          missing_packed = missing_byte
       case(NF95_SHORT)
          call nf95_get_missing(ncid, varid, missing_SHORT)
          missing_packed = missing_SHORT
       case(NF95_INT)
          call nf95_get_missing(ncid, varid, missing_packed)
       end select

       if (present(new_missing)) then
          missing = new_missing
       else
          missing = NF95_FILL_REAL
       end if

       if (ncerr_scale /= nf95_noerr) scale_factor = 1.
       if (ncerr_offset /= nf95_noerr) add_offset = 0.

       where(packed_values == missing_packed)
          values = missing
       elsewhere
          values = packed_values * scale_factor + add_offset
       end where
    else
       call nf95_get_var(ncid, varid, values, start, count_nc, &
            new_missing = new_missing)
    end if

  end subroutine nf95_gunp_var_real_2d

  !**************************************************************************

  subroutine nf95_gunp_var_real_3d(ncid, varid, values, start, count_nc, &
       new_missing)

    use nf95_constants, only: NF95_FILL_REAL

    integer, intent(in):: ncid, varid
    real, intent(out):: values(:, :, :)
    integer, optional, intent(in):: start(:), count_nc(:)
    real, optional, intent(in):: new_missing

    ! Local:
    integer xtype, missing_packed
    integer(OneByteInt) missing_byte
    integer(TwoByteInt) missing_short
    integer ncerr_scale, ncerr_offset

    integer, allocatable:: packed_values(:, :, :)
    ! we use an allocatable array instead of an automatic array
    ! because we do not know if the array is going to be useful

    real scale_factor, add_offset, missing

    !------------------------------------------------------------------------

    call nf95_get_att(ncid, varid, "scale_factor", scale_factor, ncerr_scale)
    call nf95_get_att(ncid, varid, "add_offset", add_offset, ncerr_offset)

    if (ncerr_scale == nf95_noerr .or. ncerr_offset == nf95_noerr) then
       call nf95_inquire_variable(ncid, varid, xtype = xtype)

       if (all(xtype /= [NF95_BYTE, NF95_SHORT, NF95_INT])) then
          write(error_unit, fmt = *) "nf95_gunp_var_real_3d: type of packed " &
               // "variable must be integer (any kind)"
          stop 1
       end if

       allocate(packed_values(size(values, 1), size(values, 2), &
            size(values, 3)))
       call nf95_get_var(ncid, varid, packed_values, start, count_nc)

       ! We cannot just call nf95_get_missing with argument
       ! missing_packed because we want to get the right nf95_fill_*
       ! value if there is no missing_value or _FillValue
       ! attribute. Note that the type of the missing_value or
       ! _FillValue attribute, if any, must be xtype, according to CF
       ! convention.
       select case(xtype)
       case(NF95_BYTE)
          call nf95_get_missing(ncid, varid, missing_byte)
          missing_packed = missing_byte
       case(NF95_SHORT)
          call nf95_get_missing(ncid, varid, missing_SHORT)
          missing_packed = missing_SHORT
       case(NF95_INT)
          call nf95_get_missing(ncid, varid, missing_packed)
       end select

       if (present(new_missing)) then
          missing = new_missing
       else
          missing = NF95_FILL_REAL
       end if

       if (ncerr_scale /= nf95_noerr) scale_factor = 1.
       if (ncerr_offset /= nf95_noerr) add_offset = 0.

       where(packed_values == missing_packed)
          values = missing
       elsewhere
          values = packed_values * scale_factor + add_offset
       end where
    else
       call nf95_get_var(ncid, varid, values, start, count_nc, &
            new_missing = new_missing)
    end if

  end subroutine nf95_gunp_var_real_3d

  !**************************************************************************

  subroutine nf95_gunp_var_dble(ncid, varid, values, start, count_nc, &
       new_missing)

    use nf95_constants, only: NF95_FILL_double

    integer, intent(in):: ncid, varid
    double precision, intent(out):: values(:, :, :)
    integer, optional, intent(in):: start(:), count_nc(:)
    double precision, optional, intent(in):: new_missing

    ! Local:
    integer xtype, missing_packed
    integer(OneByteInt) missing_byte
    integer(TwoByteInt) missing_short
    integer ncerr_scale, ncerr_offset

    integer, allocatable:: packed_values(:, :, :)
    ! we use an allocatable array instead of an automatic array
    ! because we do not know if the array is going to be useful

    double precision scale_factor, add_offset, missing

    !------------------------------------------------------------------------

    call nf95_get_att(ncid, varid, "scale_factor", scale_factor, ncerr_scale)
    call nf95_get_att(ncid, varid, "add_offset", add_offset, ncerr_offset)

    if (ncerr_scale == nf95_noerr .or. ncerr_offset == nf95_noerr) then
       call nf95_inquire_variable(ncid, varid, xtype = xtype)

       if (all(xtype /= [NF95_BYTE, NF95_SHORT, NF95_INT])) then
          write(error_unit, fmt = *) "nf95_gunp_var_dble: type of packed " &
               // "variable must be integer (any kind)"
          stop 1
       end if

       allocate(packed_values(size(values, 1), size(values, 2), &
            size(values, 3)))
       call nf95_get_var(ncid, varid, packed_values, start, count_nc)

       ! We cannot just call nf95_get_missing with argument
       ! missing_packed because we want to get the right nf95_fill_*
       ! value if there is no missing_value or _FillValue
       ! attribute. Note that the type of the missing_value or
       ! _FillValue attribute, if any, must be xtype, according to CF
       ! convention.
       select case(xtype)
       case(NF95_BYTE)
          call nf95_get_missing(ncid, varid, missing_byte)
          missing_packed = missing_byte
       case(NF95_SHORT)
          call nf95_get_missing(ncid, varid, missing_SHORT)
          missing_packed = missing_SHORT
       case(NF95_INT)
          call nf95_get_missing(ncid, varid, missing_packed)
       end select

       if (present(new_missing)) then
          missing = new_missing
       else
          missing = NF95_FILL_double
       end if

       if (ncerr_scale /= nf95_noerr) scale_factor = 1d0
       if (ncerr_offset /= nf95_noerr) add_offset = 0d0

       where(packed_values == missing_packed)
          values = missing
       elsewhere
          values = packed_values * scale_factor + add_offset
       end where
    else
       call nf95_get_var(ncid, varid, values, start, count_nc, &
            new_missing = new_missing)
    end if

  end subroutine nf95_gunp_var_dble

end module nf95_gunp_var_m

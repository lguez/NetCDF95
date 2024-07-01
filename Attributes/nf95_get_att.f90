module nf95_get_att_m

  use nf95_abort_m, only: nf95_abort
  use nf95_constants, only: nf95_noerr
  use nf95_inquire_attribute_m, only: nf95_inquire_attribute

  implicit none

  interface nf95_get_att
     module procedure nf95_get_att_text, nf95_get_att_one_twoByteInt, &
          nf95_get_att_one_FourByteInt, nf95_get_att_one_FourByteReal, &
          nf95_get_att_one_eightByteReal

     ! The difference between the specific procedures is the type of
     ! argument "values".
  end interface nf95_get_att

  private
  public nf95_get_att

contains

  subroutine nf95_get_att_text(ncid, varid, name, values, ncerr)

    use nc_constants, only: nc_noerr
    use, intrinsic:: ISO_C_BINDING

    integer, intent(in):: ncid, varid
    character(len = *), intent(in):: name
    character(len = *), intent(out):: values
    integer, intent(out), optional:: ncerr

    ! Variables local to the procedure:
    integer ncerr_not_opt
    integer att_len
    Integer(C_INT) cncerr

    Interface
       Integer(C_INT) Function nc_get_att_text(ncid, varid, name, values) &
            BIND(C)
         import C_INT, C_CHAR
         Integer(C_INT), VALUE, Intent(IN):: ncid, varid
         Character(KIND=C_CHAR), Intent(IN):: name(*)
         Character(KIND=C_CHAR), Intent(OUT):: values(*)
       End Function nc_get_att_text
    End Interface

    !-------------------

    ! Check that the length of "values" is large enough:
    call nf95_inquire_attribute(ncid, varid, name, nclen=att_len, &
         ncerr=ncerr_not_opt)

    if (ncerr_not_opt == nf95_noerr) then
       if (len(values) < att_len) then
          print *, "nf95_get_att_text"
          print *, "varid = ", varid
          print *, "attribute name: ", name
          print *, 'length of "values" is not large enough'
          print *, "len(values) = ", len(values)
          print *, "number of characters in attribute: ", att_len
          stop 1
       end if
    end if

    values = ""
    ! We assume that the C character kind is the same as the default
    ! character kind:
    cncerr = nc_get_att_text(int(ncid, c_int), int(varid - 1, c_int), &
         name // c_null_char, values)

    if (present(ncerr)) then
       ncerr = cncerr
    else
       if (cncerr /= nc_noerr) call nf95_abort("nf95_get_att_text " &
            // trim(name), int(cncerr), ncid, varid)
    end if

    if (att_len >= 1 .and. cncerr == nc_noerr) then
       ! Remove null terminator, if any:
       if (iachar(values(att_len:att_len)) == 0) values(att_len:att_len) = " "
    end if

  end subroutine nf95_get_att_text

  !***********************

  subroutine nf95_get_att_one_TwoByteInt(ncid, varid, name, values, ncerr)

    use netcdf, only: nf90_get_att
    use type_sizes, only: TwoByteInt

    integer, intent(in):: ncid, varid
    character(len = *), intent(in):: name
    integer (kind = TwoByteInt), intent(out):: values
    integer, intent(out), optional:: ncerr

    ! Variables local to the procedure:
    integer ncerr_not_opt
    integer att_len

    !-------------------

    ! Check that the attribute contains a single value:
    call nf95_inquire_attribute(ncid, varid, name, nclen=att_len, &
         ncerr=ncerr_not_opt)
    if (ncerr_not_opt == nf95_noerr) then
       if (att_len /= 1) then
          print *, "nf95_get_att_one_TwoByteInt"
          print *, "varid = ", varid
          print *, "attribute name: ", name
          print *, 'the attribute does not contain a single value'
          print *, "number of values in attribute: ", att_len
          stop 1
       end if
    end if

    ncerr_not_opt = nf90_get_att(ncid, varid, name, values)
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_get_att_one_TwoByteInt " // trim(name), &
            ncerr_not_opt, ncid, varid)
    end if

  end subroutine nf95_get_att_one_TwoByteInt

  !***********************

  subroutine nf95_get_att_one_FourByteInt(ncid, varid, name, values, ncerr)

    use netcdf, only: nf90_get_att
    use type_sizes, only: FourByteInt

    integer, intent(in):: ncid, varid
    character(len = *), intent(in):: name
    integer (kind = FourByteInt), intent(out):: values
    integer, intent(out), optional:: ncerr

    ! Variables local to the procedure:
    integer ncerr_not_opt
    integer att_len

    !-------------------

    ! Check that the attribute contains a single value:
    call nf95_inquire_attribute(ncid, varid, name, nclen=att_len, &
         ncerr=ncerr_not_opt)
    if (ncerr_not_opt == nf95_noerr) then
       if (att_len /= 1) then
          print *, "nf95_get_att_one_FourByteInt"
          print *, "varid = ", varid
          print *, "attribute name: ", name
          print *, 'the attribute does not contain a single value'
          print *, "number of values in attribute: ", att_len
          stop 1
       end if
    end if

    ncerr_not_opt = nf90_get_att(ncid, varid, name, values)
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_get_att_one_FourByteInt " // trim(name), &
            ncerr_not_opt, ncid, varid)
    end if

  end subroutine nf95_get_att_one_FourByteInt

  !***********************

  subroutine nf95_get_att_one_FourByteReal(ncid, varid, name, values, ncerr)

    use netcdf, only: nf90_get_att
    use type_sizes, only: FourByteReal

    integer, intent(in):: ncid, varid
    character(len = *), intent(in):: name
    real (kind = FourByteReal), intent(out):: values
    integer, intent(out), optional:: ncerr

    ! Variables local to the procedure:
    integer ncerr_not_opt
    integer att_len

    !-------------------

    ! Check that the attribute contains a single value:
    call nf95_inquire_attribute(ncid, varid, name, nclen=att_len, &
         ncerr=ncerr_not_opt)
    if (ncerr_not_opt == nf95_noerr) then
       if (att_len /= 1) then
          print *, "nf95_get_att_one_Fourbytereal"
          print *, "varid = ", varid
          print *, "attribute name: ", name
          print *, 'the attribute does not contain a single value'
          print *, "number of values in attribute: ", att_len
          stop 1
       end if
    end if

    ncerr_not_opt = nf90_get_att(ncid, varid, name, values)
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_get_att_one_Fourbytereal " // trim(name), &
            ncerr_not_opt, ncid, varid)
    end if

  end subroutine nf95_get_att_one_Fourbytereal

  !***********************

  subroutine nf95_get_att_one_EightByteReal(ncid, varid, name, values, ncerr)

    use netcdf, only: nf90_get_att
    use type_sizes, only: EightByteReal

    integer, intent(in):: ncid, varid
    character(len = *), intent(in):: name
    real (kind = EightByteReal), intent(out):: values
    integer, intent(out), optional:: ncerr

    ! Variables local to the procedure:
    integer ncerr_not_opt
    integer att_len

    !-------------------

    ! Check that the attribute contains a single value:
    call nf95_inquire_attribute(ncid, varid, name, nclen=att_len, &
         ncerr=ncerr_not_opt)
    if (ncerr_not_opt == nf95_noerr) then
       if (att_len /= 1) then
          print *, "nf95_get_att_one_Eightbytereal"
          print *, "varid = ", varid
          print *, "attribute name: ", name
          print *, 'the attribute does not contain a single value'
          print *, "number of values in attribute: ", att_len
          stop 1
       end if
    end if

    ncerr_not_opt = nf90_get_att(ncid, varid, name, values)
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_get_att_one_Eightbytereal " // trim(name), &
            ncerr_not_opt, ncid, varid)
    end if

  end subroutine nf95_get_att_one_Eightbytereal

end module nf95_get_att_m

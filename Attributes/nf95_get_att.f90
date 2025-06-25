module nf95_get_att_m

  use nf95_abort_m, only: nf95_abort
  use nf95_constants, only: nf95_noerr
  use nf95_inquire_attribute_m, only: nf95_inquire_attribute
  use nf95_get_att_text_m, only: nf95_get_att_text

  implicit none

  interface nf95_get_att
     module procedure nf95_get_att_text, nf95_get_att_one_twoByteInt, &
          nf95_get_att_one_FourByteInt, nf95_get_att_one_FourByteReal, &
          nf95_get_att_one_eightByteReal, nf95_get_att_one_oneByteInt

     ! The difference between the specific procedures is the type of
     ! argument "values".
  end interface nf95_get_att

  private
  public nf95_get_att

contains

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

  subroutine nf95_get_att_one_oneByteInt(ncid, varid, name, values, ncerr)

    use netcdf, only: nf90_get_att
    use type_sizes, only: oneByteInt

    integer, intent(in):: ncid, varid
    character(len = *), intent(in):: name
    integer (kind = oneByteInt), intent(out):: values
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
          print *, "nf95_get_att_one_oneByteInt"
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
            nf95_abort("nf95_get_att_one_oneByteInt " // trim(name), &
            ncerr_not_opt, ncid, varid)
    end if

  end subroutine nf95_get_att_one_oneByteInt

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

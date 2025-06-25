module nf95_get_att_text_m

  implicit none

contains

  subroutine nf95_get_att_text(ncid, varid, name, values, ncerr)

    use, intrinsic:: ISO_C_BINDING
    use, intrinsic:: ISO_fortran_env

    use nf95_abort_m, only: nf95_abort
    use nf95_constants, only: nc_noerr, nf95_ests, nf95_char, nf95_noerr
    use nf95_inquire_attribute_m, only: nf95_inquire_attribute

    integer, intent(in):: ncid, varid
    character(len = *), intent(in):: name
    character(len = *), intent(out):: values
    integer, intent(out), optional:: ncerr

    ! Variables local to the procedure:
    integer ncerr_inquire, i
    integer xtype, att_len
    Integer(C_INT) cncerr
    integer(c_size_t) c_att_len

    Interface
       Integer(C_INT) Function nc_get_att_text(ncid, varid, name, values) &
            BIND(C)
         import C_INT, C_CHAR
         Integer(C_INT), VALUE, Intent(IN):: ncid, varid
         Character(KIND=C_CHAR), Intent(IN):: name(*)
         Character(KIND=C_CHAR), Intent(OUT):: values(*)
       End Function nc_get_att_text

       Integer(C_INT) Function nc_get_att_1_string(ncid, varid, name, values, &
            c_att_len, size_values) BIND(C)
         import C_INT, C_CHAR, C_size_t
         Integer(C_INT), VALUE, Intent(IN):: ncid, varid
         Character(KIND=C_CHAR), Intent(IN):: name(*)
         Character(KIND=C_CHAR), Intent(OUT):: values(*)
         integer(c_size_t), intent(out):: c_att_len
         Integer(C_size_t), VALUE, Intent(IN):: size_values
       End Function nc_get_att_1_string
    End Interface

    !-------------------

    call nf95_inquire_attribute(ncid, varid, name, xtype, att_len, &
         ncerr=ncerr_inquire)

    test_ncerr_inquire: if (ncerr_inquire == nf95_noerr) then
       test_xtype: if (xtype == nf95_char) then
          if (len(values) >= att_len) then
             values = ""
             ! We assume that the C character kind is the same as the default
             ! character kind:
             cncerr = nc_get_att_text(int(ncid, c_int), int(varid - 1, c_int), &
                  name // c_null_char, values)

             if (cncerr == nc_noerr) then
                if (att_len >= 1) then
                   ! Remove null terminator, if any:
                   if (values(att_len:att_len) == c_null_char) &
                        values(att_len:att_len) = " "
                end if

                if (present(ncerr)) ncerr = nf95_noerr
             else
                if (present(ncerr)) then
                   ncerr = cncerr
                else
                   call nf95_abort("nf95_get_att_text -> nc_get_att_text " &
                        // trim(name), int(cncerr), ncid, varid)
                end if
             end if
          else
             if (present(ncerr)) then
                ncerr = nf95_ests
             else
                write(error_unit, fmt = *) "attribute name: ", name
                write(error_unit, fmt = *) &
                     'length of "values" is not large enough'
                write(error_unit, fmt = *) "len(values) = ", len(values)
                write(error_unit, fmt = *) &
                     "number of characters in attribute: ", att_len
                call nf95_abort("nf95_get_att_text", nf95_ests, ncid, varid)
             end if
          end if
       else test_xtype
          ! Assume string type

          values = ""
          ! We assume that the C character kind is the same as the default
          ! character kind:
          cncerr = nc_get_att_1_string(int(ncid, c_int), &
               int(varid - 1, c_int), name // c_null_char, values, c_att_len, &
               size_values = len(values, c_size_t))

          if (cncerr == nc_noerr) then
             ! Remove null terminator, if any:
             i = c_att_len + 1
             if (values(i:i) == c_null_char) values(i:i) = " "

             if (present(ncerr)) ncerr = nf95_noerr
          else
             if (present(ncerr)) then
                ncerr = cncerr
             else
                write(error_unit, fmt = *) "attribute name: ", name
                write(error_unit, fmt = *) "type of attribute: ", xtype
                call nf95_abort("nf95_get_att_text -> nc_get_att_1_string ", &
                     int(cncerr), ncid, varid)
             end if
          end if
       end if test_xtype
    else test_ncerr_inquire
       if (present(ncerr)) then
          ncerr = ncerr_inquire
       else
          write(error_unit, fmt = *) "attribute name: ", name
          call nf95_abort("nf95_get_att_text -> nf95_inquire_attribute ", &
               ncerr_inquire, ncid, varid)
       end if
    end if test_ncerr_inquire

  end subroutine nf95_get_att_text

end module nf95_get_att_text_m

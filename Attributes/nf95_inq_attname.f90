module nf95_inq_attname_m

  implicit none

contains

  subroutine nf95_inq_attname(ncid, varid, attnum, name, ncerr)

    ! Find the name of an attribute for a given varid and attribute
    ! number.

    use, intrinsic:: ISO_C_BINDING

    use nc_constants, only: nc_noerr
    use nf95_abort_m, only: nf95_abort
    use nf95_constants, only: nf95_max_name

    integer, intent(in):: ncid, varid, attnum
    character(len = :), allocatable, intent(out):: name
    integer, intent(out), optional:: ncerr

    ! Local:

    integer(C_INT) cncerr
    integer i_null

    Character(KIND = C_CHAR, LEN = nf95_max_name + 1) tmpname
    ! There is no way in the C interface to know the length of an
    ! attribute knowing only its number. We have to inquire about the
    ! name of the attribute first. So we have to make an assumption
    ! about the maximum size to inquire about the name.

    Interface
       Integer(C_INT) Function nc_inq_attname(ncid, varid, attnum, name) BIND(C)
         import c_int, C_CHAR
         Integer(C_INT), VALUE, intent(in):: ncid, varid, attnum
         Character(KIND = C_CHAR), intent(OUT) :: name(*)
       End Function nc_inq_attname
    End Interface

    !---------------------------------------------------------

    cncerr = nc_inq_attname(int(ncid, c_int), int(varid - 1, c_int), &
         int(attnum - 1, c_int), tmpname)

    if (cncerr == nc_noerr) then
       i_null = SCAN(tmpname, C_NULL_CHAR)
       if (i_null <= 1) call nf95_abort("nf95_inq_attname scan", ncid = ncid, &
            varid = varid, attnum = attnum)
       name = tmpname(1:i_null - 1)
       if (present(ncerr)) ncerr = nc_noerr
    else
       if (present(ncerr)) then
          ncerr = cncerr
       else
          call nf95_abort("nf95_inq_attname nc_inq_attname", int(cncerr), &
               ncid, varid, attnum)
       end if
    end if

  end subroutine nf95_inq_attname

end module nf95_inq_attname_m

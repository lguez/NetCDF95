module nf95_inq_grpname_full_m

  implicit none

contains

  subroutine nf95_inq_grpname_full(ncid, full_name, ncerr)

    use, intrinsic:: ISO_C_BINDING

    use nc_constants, only: NC_NOERR
    use nc_inq_grpname_len_m, only: nc_inq_grpname_len
    use nf95_abort_m, only: nf95_abort
    use nf95_constants, only: nf95_noerr

    integer, intent(in):: ncid
    character(len = :), allocatable, intent(out):: full_name ! absolute path
    integer, intent(out), optional:: ncerr

    ! Local:

    integer(C_INT) cncerr, cncid
    integer(C_SIZE_T) lenp
    integer inull

    Interface
       Integer(C_INT) Function nc_inq_grpname_full(ncid, lenp, full_name) &
            BIND(C)
         import C_INT, C_SIZE_T, C_CHAR
         Integer(C_INT), VALUE, intent(in):: ncid
         Integer(C_SIZE_T), Intent(OUT):: lenp
         Character(KIND=C_CHAR), Intent(OUT):: full_name(*)
       End Function nc_inq_grpname_full
    End Interface

    !-------------------------------------------------------------------

    cncid = int(ncid, c_int)
    cncerr = Nc_INQ_GRPNAME_LEN(cncid, lenp)

    if (cncerr == nc_noerr) then
       allocate(character(len = lenp + 1):: full_name)

       ! We assume that the C character kind is the same as the default
       ! character kind:
       cncerr = nc_inq_grpname_full(cncid, lenp, full_name)

       if (cncerr == nc_noerr) then
          inull = SCAN(full_name, C_NULL_CHAR)
          if (inull /= 0) full_name = full_name(:inull - 1)
          if (present(ncerr)) ncerr = nf95_noerr
       else
          if (present(ncerr)) then
             ncerr = cncerr
          else
             call nf95_abort("nf95_inq_grpname_full", int(cncerr), ncid)
          end if
       end if
    else
       if (present(ncerr)) then
          ncerr = cncerr
       else
          call nf95_abort("nf95_inq_grpname_full -- Nc_INQ_GRPNAME_LEN", &
               int(cncerr), ncid)
       end if
    end if

  end subroutine nf95_inq_grpname_full

end module nf95_inq_grpname_full_m

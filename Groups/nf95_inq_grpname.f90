module nf95_inq_grpname_m

  implicit none

contains

  subroutine nf95_inq_grpname(ncid, name, ncerr)

    use, intrinsic:: ISO_C_BINDING

    use nf95_abort_m, only: nf95_abort
    use nc_constants, only: NC_NOERR

    integer, intent(in):: ncid ! can be the file id or a group id
    character(len = :), allocatable, intent(out):: name ! without path
    integer, intent(out), optional:: ncerr

    ! Local:

    Integer(C_INT) cstatus, cncid
    Integer(C_SIZE_T) lenp
    integer inull

    Interface
       Integer(C_INT) Function nc_inq_grpname_len(ncid, lenp) BIND(C)
         import c_int, C_SIZE_T
         Integer(C_INT), VALUE, Intent(IN):: ncid

         Integer(C_SIZE_T), Intent(OUT):: lenp
         ! does not include NULL terminator
       End Function nc_inq_grpname_len
       
       Integer(C_INT) Function nc_inq_grpname(ncid, name) BIND(C)
         import c_int, C_CHAR
         Integer(C_INT), VALUE, Intent(IN):: ncid
         CHARACTER(kind=C_CHAR), Intent(OUT):: name(*)
       End Function nc_inq_grpname
    End Interface

    !------------------------------------------------------------

    cncid = int(ncid, c_int)
    cstatus = nc_inq_grpname_len(cncid, lenp)
    if (cstatus /= nc_noerr) call &
         nf95_abort("nf95_inq_grpname -- nc_inq_grpname_len", int(cstatus), &
         ncid)
    allocate(character(lenp + 1):: name)

    ! We assume that the C character kind is the same as the default
    ! character kind:
    cstatus = nc_inq_grpname(cncid, name)

    if (present(ncerr)) then
       ncerr = cstatus
    else
       if (cstatus /= nc_noerr) call &
            nf95_abort("nf95_inq_grps -- nc_inq_grpname", int(cstatus), ncid)
    end if

    if (cstatus == nc_noerr) then
       inull = SCAN(name, C_NULL_CHAR)
       if (inull /= 0) name = name(:inull - 1)
    end if

  end subroutine nf95_inq_grpname

end module nf95_inq_grpname_m

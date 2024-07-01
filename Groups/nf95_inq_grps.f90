module nf95_inq_grps_m

  implicit none

contains

  subroutine nf95_inq_grps(ncid, ncids, ncerr)

    use, intrinsic:: ISO_C_BINDING

    use nc_constants, only: nc_noerr
    use nf95_abort_m, only: nf95_abort
    use nf95_constants, only: nf95_noerr

    integer, intent(in):: ncid ! can be the file id or a group id
    integer, allocatable, intent(out):: ncids(:) ! immediate subgroups
    integer, intent(out), optional:: ncerr

    ! Local:

    Integer(C_INT) numgrps, cstatus, cncid
    integer(C_INT), allocatable:: cncids(:)

    Interface
       Integer(C_INT) Function nc_inq_grps(ncid, numgrps, ncids) BIND(C)
         import c_int
         Integer(C_INT), VALUE, intent(in):: ncid
         Integer(C_INT), Intent(OUT):: numgrps
         Integer(C_INT), Intent(OUT):: ncids(*)
       End Function nc_inq_grps

       Integer(C_INT) Function nc_inq_grps_pointer(ncid, numgrps, ncids) &
            BIND(C, name = "nc_inq_grps")
         ! Second Fortran interface for the same C function
         import c_int, c_ptr
         Integer(C_INT), VALUE, intent(in):: ncid
         Integer(C_INT), Intent(OUT):: numgrps
         type(c_ptr), Intent(in), value:: ncids
       End Function nc_inq_grps_pointer
    End Interface

    !------------------------------------------------------------

    cncid = ncid
    cstatus = nc_inq_grps_pointer(cncid, numgrps, c_null_ptr)
    if (cstatus /= nc_noerr) call &
         nf95_abort("nf95_inq_grps -- nc_inq_grps_pointer", int(cstatus), ncid)

    if (numgrps >= 1) then
       allocate(cncids(numgrps))
       cstatus = nc_inq_grps(cncid, numgrps, cncids)

       if (present(ncerr)) then
          ncerr = cstatus
       else
          if (cstatus /= nc_noerr) call &
               nf95_abort("nf95_inq_grps -- nc_inq_grps", int(cstatus), ncid)
       end if

       if (cstatus == nf95_noerr) ncids = cncids
    else
       allocate(ncids(0))
    end if

  end subroutine nf95_inq_grps

end module nf95_inq_grps_m

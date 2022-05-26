module nf95_inq_grps_m

  implicit none

contains

  subroutine nf95_inq_grps(ncid, ncids, ncerr)

    use, intrinsic:: ISO_C_BINDING

    use netcdf, only: nf90_noerr
    use handle_err_m, only: handle_err

    integer, intent(in):: ncid ! can be the file id or a group id
    integer, allocatable, intent(out):: ncids(:)
    integer, intent(out), optional:: ncerr

    ! Local:

    Integer(C_INT) numgrps, cstatus
    integer(C_INT), allocatable:: cncids(:)

    Interface
       Integer(C_INT) Function inq_numgrps(ncid, numgrps) BIND(C)
         import c_int
         Integer(C_INT), VALUE:: ncid
         Integer(C_INT), Intent(OUT):: numgrps
       End Function inq_numgrps

       Integer(C_INT) Function nc_inq_grps(ncid, numgrps, ncids) BIND(C)
         import c_int
         Integer(C_INT), VALUE:: ncid
         Integer(C_INT), Intent(OUT):: numgrps
         Integer(C_INT), Intent(OUT):: ncids(*)
       End Function nc_inq_grps
    End Interface

    !------------------------------------------------------------

    cstatus = inq_numgrps(int(ncid, c_int), numgrps)
    call handle_err("nf95_inq_grps -- inq_numgrps", int(cstatus), ncid)

    if (numgrps >= 1) then
       allocate(cncids(numgrps))
       cstatus = nc_inq_grps(int(ncid, c_int), numgrps, cncids)

       if (present(ncerr)) then
          ncerr = cstatus
       else
          call handle_err("nf95_inq_grps -- nc_inq_grps", int(cstatus), ncid)
       end if

       if (cstatus == nf90_noerr) ncids = cncids
    else
       allocate(ncids(0))
    end if

  end subroutine nf95_inq_grps

end module nf95_inq_grps_m

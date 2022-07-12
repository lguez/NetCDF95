module nf95_inq_grp_parent_m

  implicit none

contains

  subroutine nf95_inq_grp_parent(ncid, parent_ncid, ncerr)

    ! Note that this procedure is indirectly called by nf95_abort, so
    ! it cannot call it.

    use, intrinsic:: ISO_C_BINDING

    use netcdf, only: nf90_strerror

    use nc_constants, only: NC_NOERR
    use nf95_constants, only: nf95_noerr

    integer, intent(in):: ncid
    integer, intent(out):: parent_ncid
    integer, intent(out), optional:: ncerr

    ! Local:

    Integer(C_INT) cparent_ncid, cncerr

    Interface
       Integer(C_INT) Function nc_inq_grp_parent(cncid, cparent_ncid) BIND(C)
         import c_int
         Integer(C_INT), VALUE:: cncid
         Integer(C_INT), Intent(OUT) :: cparent_ncid
       End Function nc_inq_grp_parent
    End Interface

    !------------------------------------------------------------

    cncerr = nc_inq_grp_parent(int(ncid, c_int), cparent_ncid)

    if (cncerr == NC_NOERR) then
       parent_ncid = cparent_ncid
       if (present(ncerr)) ncerr = nf95_noerr
    else
       if (present(ncerr)) then
          ncerr = cncerr
       else
          print *, "nf95_inq_grp_parent:"
          print *, trim(nf90_strerror(int(cncerr)))
          stop 1
       end if
    end if

  end subroutine nf95_inq_grp_parent

end module nf95_inq_grp_parent_m

module nf95_inq_varid_m

  implicit none

contains

  subroutine nf95_inq_varid(ncid, name, varid, ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_inq_varid
    use nf95_constants, only: nf95_noerr

    integer,             intent(in) :: ncid
    character(len=*), intent(in):: name
    integer,             intent(out) :: varid
    integer, intent(out), optional:: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_inq_varid(ncid, name, varid)
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_inq_varid, name = " // name, ncerr_not_opt, ncid)
    end if

  end subroutine nf95_inq_varid

end module nf95_inq_varid_m

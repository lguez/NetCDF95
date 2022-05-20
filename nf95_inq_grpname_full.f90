module nf95_inq_grpname_full_m

  implicit none

contains

  subroutine nf95_inq_grpname_full(grpid, name, ncerr)

    use handle_err_m, only: handle_err
    use netcdf, only: nf90_inq_grpname_full, NF90_MAX_NAME, nf90_noerr

    integer, intent(in):: grpid
    character(len = :), allocatable, intent(out):: name
    integer, intent(out), optional:: ncerr

    ! Local:
    integer ncerr_not_opt, nclen
    character(len = NF90_MAX_NAME) name_local

    !-------------------------------------------------------------------

    ncerr_not_opt = nf90_inq_grpname_full(grpid, nclen, name_local)

    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       call handle_err("nf95_inq_grpname_full", ncerr_not_opt, grpid)
    end if

    if (ncerr_not_opt == nf90_noerr) then
       name = name_local(:nclen)
    end if

  end subroutine nf95_inq_grpname_full

end module nf95_inq_grpname_full_m

module nf95_inq_grpname_full_m

  implicit none

contains

  subroutine nf95_inq_grpname_full(grpid, name, ncerr)

    use handle_err_m, only: handle_err
    use netcdf, only: nf90_inq_grpname_full, NF90_INQ_GRPNAME_LEN

    integer, intent(in):: grpid
    character(len = :), allocatable, intent(out):: name ! absolute path
    integer, intent(out), optional:: ncerr

    ! Local:
    integer ncerr_not_opt, nclen

    !-------------------------------------------------------------------

    ncerr_not_opt = NF90_INQ_GRPNAME_LEN(grpid, nclen)
    call handle_err("nf95_inq_grpname_full -- NF90_INQ_GRPNAME_LEN", &
         ncerr_not_opt, grpid)
    allocate(character(len = nclen):: name)
    ncerr_not_opt = nf90_inq_grpname_full(grpid, nclen, name)

    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       call handle_err("nf95_inq_grpname_full", ncerr_not_opt, grpid)
    end if

  end subroutine nf95_inq_grpname_full

end module nf95_inq_grpname_full_m

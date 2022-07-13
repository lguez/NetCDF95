module nf95_inq_grpname_full_m

  implicit none

contains

  subroutine nf95_inq_grpname_full(ncid, full_name, ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_inq_grpname_full, NF90_INQ_GRPNAME_LEN
    use nf95_constants, only: nf95_noerr

    integer, intent(in):: ncid
    character(len = :), allocatable, intent(out):: full_name ! absolute path
    integer, intent(out), optional:: ncerr

    ! Local:
    integer ncerr_not_opt, nclen

    !-------------------------------------------------------------------

    ncerr_not_opt = NF90_INQ_GRPNAME_LEN(ncid, nclen)
    if (ncerr_not_opt /= nf95_noerr) call &
         nf95_abort("nf95_inq_grpname_full -- NF90_INQ_GRPNAME_LEN", &
         ncerr_not_opt, ncid)
    allocate(character(len = nclen):: full_name)
    ncerr_not_opt = nf90_inq_grpname_full(ncid, nclen, full_name)

    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_inq_grpname_full", ncerr_not_opt, ncid)
    end if

  end subroutine nf95_inq_grpname_full

end module nf95_inq_grpname_full_m

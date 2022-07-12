module nf95_sync_m

  implicit none

contains

  subroutine nf95_sync(ncid, ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_sync
    use nf95_constants, only: nf95_noerr

    integer, intent( in) :: ncid
    integer, intent(out), optional :: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_sync(ncid)

    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call nf95_abort("nf95_sync", &
            ncerr_not_opt, ncid)
    end if

  end subroutine nf95_sync

end module nf95_sync_m

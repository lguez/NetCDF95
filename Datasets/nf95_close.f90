module nf95_close_m

  implicit none

contains

  subroutine nf95_close(ncid, ncerr)

    ! Note that this procedure is called by nf95_abort, so it cannot
    ! call it.

    use netcdf, only: nf90_close, nf90_strerror

    use nf95_constants, only: nf95_noerr

    integer, intent(in):: ncid
    integer, intent(out), optional:: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_close(ncid)

    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) then
          print *, "nf95_close:"
          print *, trim(nf90_strerror(ncerr_not_opt))
          stop 1
       end if
    end if

  end subroutine nf95_close

end module nf95_close_m

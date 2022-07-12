module nf95_redef_m

  implicit none

contains

  subroutine nf95_redef(ncid, ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_redef
    use nf95_constants, only: nf95_noerr

    integer, intent( in) :: ncid
    integer, intent(out), optional :: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_redef(ncid)

    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call nf95_abort("nf95_redef", &
            ncerr_not_opt, ncid)
    end if

  end subroutine nf95_redef

end module nf95_redef_m

module nf95_inquire_dimension_m

  implicit none

contains

  subroutine nf95_inquire_dimension(ncid, dimid, name, nclen, ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_inquire_dimension
    use nf95_constants, only: nf95_noerr

    integer,                       intent( in) :: ncid, dimid
    character (len = *), optional, intent(out) :: name
    integer,             optional, intent(out) :: nclen
    integer, intent(out), optional:: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_inquire_dimension(ncid, dimid, name, nclen)
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_inquire_dimension", ncerr_not_opt, ncid)
    end if

  end subroutine nf95_inquire_dimension

end module nf95_inquire_dimension_m

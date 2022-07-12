module nf95_create_m

  implicit none

contains

  subroutine nf95_create(path, cmode, ncid, initialsize, chunksize, ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_create
    use nf95_constants, only: nf95_noerr

    character (len = *), intent(in   ) :: path
    integer,             intent(in   ) :: cmode
    integer,             intent(  out) :: ncid
    integer, optional,   intent(in   ) :: initialsize
    integer, optional,   intent(inout) :: chunksize
    integer, intent(out), optional :: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_create(path, cmode, ncid, initialsize, chunksize)

    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_create " // path, ncerr_not_opt)
    end if

  end subroutine nf95_create

end module nf95_create_m

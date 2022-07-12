module nf95_def_dim_m

  implicit none

contains

  subroutine nf95_def_dim(ncid, name, nclen, dimid, ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_def_dim
    use nf95_constants, only: nf95_noerr

    integer,             intent( in) :: ncid
    character (len = *), intent( in) :: name
    integer,             intent( in) :: nclen
    integer,             intent(out) :: dimid
    integer, intent(out), optional :: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_def_dim(ncid, name, nclen, dimid)
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call nf95_abort("nf95_def_dim " &
            // name, ncerr_not_opt, ncid)
    end if

  end subroutine nf95_def_dim

end module nf95_def_dim_m

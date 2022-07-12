module nf95_inquire_m

  implicit none

contains


  subroutine nf95_inquire(ncid, nDimensions, nVariables, nAttributes, &
       unlimitedDimId, formatNum, ncerr)
    
    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_inquire
    use nf95_constants, only: nf95_noerr

    integer,           intent( in) :: ncid
    integer, optional, intent(out) :: nDimensions, nVariables, nAttributes
    integer, optional, intent(out) :: unlimitedDimId, formatNum
    integer, intent(out), optional:: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_inquire(ncid, nDimensions, nVariables, nAttributes, &
         unlimitedDimId, formatNum)

    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call nf95_abort("nf95_inquire", &
            ncerr_not_opt, ncid)
    end if

  end subroutine nf95_inquire

end module nf95_inquire_m

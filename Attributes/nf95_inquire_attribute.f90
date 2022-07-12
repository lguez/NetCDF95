module nf95_inquire_attribute_m

  implicit none

contains


  subroutine nf95_inquire_attribute(ncid, varid, name, xtype, nclen, attnum, &
       ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_inquire_attribute
    use nf95_constants, only: nf95_noerr

    integer,             intent( in)           :: ncid, varid
    character (len = *), intent( in)           :: name
    integer,             intent(out), optional :: xtype, nclen, attnum
    integer, intent(out), optional:: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_inquire_attribute(ncid, varid, name, xtype, nclen, &
         attnum)
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_inquire_attribute " // name, ncerr_not_opt, &
            ncid, varid)
    end if

  end subroutine nf95_inquire_attribute

end module nf95_inquire_attribute_m

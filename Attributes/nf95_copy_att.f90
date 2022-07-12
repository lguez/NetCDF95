module nf95_copy_att_m

  implicit none

contains


  subroutine nf95_copy_att(ncid_in, varid_in, name, ncid_out, varid_out, ncerr)

    use netcdf, only: nf90_copy_att

    use nf95_abort_m, only: nf95_abort
    use nf95_constants, only: nf95_noerr

    integer, intent( in):: ncid_in,  varid_in
    character(len=*), intent( in):: name
    integer, intent( in):: ncid_out, varid_out
    integer, intent(out), optional:: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_copy_att(ncid_in, varid_in, name, ncid_out, varid_out)
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call nf95_abort("nf95_copy_att " &
            // name, ncerr_not_opt, ncid_out)
    end if

  end subroutine nf95_copy_att

end module nf95_copy_att_m

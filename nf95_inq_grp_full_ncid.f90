module nf95_inq_grp_full_ncid_m

  implicit none

contains

  subroutine nf95_inq_grp_full_ncid(ncid, full_name, grpid, ncerr)

    use handle_err_m, only: handle_err
    use netcdf, only: nf90_inq_grp_full_ncid

    integer, intent(in):: ncid ! can be the file id or a group id
    character(len = *), intent(in):: full_name ! should be a relative path
    integer, intent(out):: grpid
    integer, intent(out), optional:: ncerr

    ! Local:
    integer ncerr_not_opt

    !------------------------------------------------------------

    ncerr_not_opt = nf90_inq_grp_full_ncid(ncid, full_name, grpid)
    
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       call handle_err("nf95_inq_grp_full_ncid " // trim(full_name), &
            ncerr_not_opt, ncid)
    end if

  end subroutine nf95_inq_grp_full_ncid
    
end module nf95_inq_grp_full_ncid_m

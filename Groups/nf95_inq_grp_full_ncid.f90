module nf95_inq_grp_full_ncid_m

  implicit none

contains

  subroutine nf95_inq_grp_full_ncid(ncid, full_name, grpid, ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_inq_grp_full_ncid
    use nf95_constants, only: nf95_noerr

    integer, intent(in):: ncid ! can be the file id or a group id

    character(len = *), intent(in):: full_name
    ! Should be a path relative to ncid (which can correspond to the
    ! root group or a subgroup). Can be an immediate subgroup or a
    ! deeper subgroup.

    integer, intent(out):: grpid
    integer, intent(out), optional:: ncerr

    ! Local:
    integer ncerr_not_opt

    !------------------------------------------------------------

    ncerr_not_opt = nf90_inq_grp_full_ncid(ncid, full_name, grpid)
    
    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call &
            nf95_abort("nf95_inq_grp_full_ncid " // trim(full_name), &
            ncerr_not_opt, ncid)
    end if

  end subroutine nf95_inq_grp_full_ncid
    
end module nf95_inq_grp_full_ncid_m

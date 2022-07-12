module nf95_inq_file_ncid_m

  implicit none

contains

  subroutine nf95_inq_file_ncid(ncid_file, grpid, ncerr)

    use netcdf, only: nf90_strerror

    use nf95_constants, only: Nf95_ENOGRP, nf95_noerr
    use nf95_inq_grp_parent_m, only: nf95_inq_grp_parent

    integer, intent(out):: ncid_file
    integer, intent(in):: grpid
    integer, intent(out), optional:: ncerr

    ! Local:
    integer parent_ncid, ncerr_local

    !--------------------------------------------------------------------

    ncid_file = grpid

    do
       call nf95_inq_grp_parent(ncid_file, parent_ncid, ncerr_local)
       if (ncerr_local /= nf95_noerr) exit
       ncid_file = parent_ncid
    end do

    if (ncerr_local == NF95_ENOGRP) then
       ! ncid_file is the root group
       if (present(ncerr)) ncerr = nf95_noerr
    else
       if (present(ncerr)) then
          ncerr = ncerr_local
       else
          print *, "nf95_inq_file_ncid: nf95_inq_grp_parent failed"
          print *, trim(nf90_strerror(ncerr_local))
          stop 1
       end if
    end if

  end subroutine nf95_inq_file_ncid

end module nf95_inq_file_ncid_m

module handle_err_m

  implicit none

contains

  subroutine handle_err(message, ncerr, ncid, varid)

    use netcdf, only: nf90_strerror, nf90_noerr, nf90_close, NF90_ENOGRP, &
         nf90_inq_grp_parent

    character(len=*), intent(in):: message
    ! (should include name of calling procedure)

    integer, intent(in):: ncerr

    integer, intent(in), optional :: ncid
    ! This can be the file ncid or a group ncid. Provide this argument
    ! if you want "handle_err" to try to close the file.

    integer, intent(in), optional :: varid

    ! Variable local to the procedure:
    integer ncerr_local, parent_ncid, ncid_local

    !-------------------

    if (ncerr /= nf90_noerr) then
       print *, message, ":"
       if (present(varid)) print *, "varid = ", varid
       print *, trim(nf90_strerror(ncerr))

       if (present(ncid)) then
          ! Try to close, to leave the file in a consistent state:

          ! Find the ncid of the file:
          ncid_local = ncid

          do
             ncerr_local = nf90_inq_grp_parent(ncid_local, parent_ncid)

             if (ncerr_local == NF90_ENOGRP) then
                ! ncid_local is the root group
                exit
             elseif (ncerr_local /= nf90_noerr) then
                print *, "handle_err nf90_inq_grp_parent failed"
                stop 1
             end if

             ncid_local = parent_ncid
          end do

          ncerr_local = nf90_close(ncid_local)
          ! (do not call "nf95_close", we do not want to recurse)

          if (ncerr_local /= nf90_noerr) then
             print *, "nf90_close:"
             print *, trim(nf90_strerror(ncerr_local))
          end if
       end if
       stop 1
    end if

  end subroutine handle_err

end module handle_err_m

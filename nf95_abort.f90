module nf95_abort_m

  implicit none

contains

  subroutine nf95_abort(message, ncerr, ncid, varid)

    use, intrinsic:: iso_fortran_env

    ! Libraries:
    use netcdf, only: nf90_strerror

    use nf95_close_m, only: nf95_close
    use nf95_inq_file_ncid_m, only: nf95_inq_file_ncid

    character(len=*), intent(in):: message
    ! (should include name of calling procedure)

    integer, intent(in):: ncerr

    integer, intent(in), optional :: ncid
    ! This can be the file ncid or a group ncid. Provide this argument
    ! if you want nf95_abort to try to close the file.

    integer, intent(in), optional :: varid

    ! Local:
    integer ncid_local

    !-------------------

    write(error_unit, fmt = *) message, ":"
    if (present(varid)) write(error_unit, fmt = *) "varid = ", varid
    write(error_unit, fmt = *) trim(nf90_strerror(ncerr))

    if (present(ncid)) then
       ! Try to close, to leave the file in a consistent state:
       call nf95_inq_file_ncid(ncid_local, ncid)
       call nf95_close(ncid_local)
    end if

    stop 1

  end subroutine nf95_abort

end module nf95_abort_m

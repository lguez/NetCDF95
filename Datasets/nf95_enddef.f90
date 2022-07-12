module nf95_enddef_m

  implicit none

contains

  subroutine nf95_enddef(ncid, h_minfree, v_align, v_minfree, r_align, ncerr)

    use nf95_abort_m, only: nf95_abort
    use netcdf, only: nf90_enddef
    use nf95_constants, only: nf95_noerr

    integer,           intent( in) :: ncid
    integer, optional, intent( in) :: h_minfree, v_align, v_minfree, r_align
    integer, intent(out), optional :: ncerr

    ! Variable local to the procedure:
    integer ncerr_not_opt

    !-------------------

    ncerr_not_opt = nf90_enddef(ncid, h_minfree, v_align, v_minfree, r_align)

    if (present(ncerr)) then
       ncerr = ncerr_not_opt
    else
       if (ncerr_not_opt /= nf95_noerr) call nf95_abort("nf95_enddef", &
            ncerr_not_opt, ncid)
    end if

  end subroutine nf95_enddef

end module nf95_enddef_m

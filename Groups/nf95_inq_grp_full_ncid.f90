module nf95_inq_grp_full_ncid_m

  implicit none

contains

  subroutine nf95_inq_grp_full_ncid(ncid, full_name, grp_ncid, ncerr)

    use, intrinsic:: ISO_C_BINDING

    use nc_constants, only: NC_NOERR
    use nf95_abort_m, only: nf95_abort
    use nf95_constants, only: nf95_noerr

    integer, intent(in):: ncid ! can be the file id or a group id

    character(len = *), intent(in):: full_name
    ! Should be a path relative to ncid (which can correspond to the
    ! root group or a subgroup). Can be an immediate subgroup or a
    ! deeper subgroup.

    integer, intent(out):: grp_ncid
    integer, intent(out), optional:: ncerr

    ! Local:
    Integer(C_INT) cncerr, cgrp_ncid

    Interface
       Integer(C_INT) Function nc_inq_grp_full_ncid(cncid, full_name, &
            cgrp_ncid) BIND(C)
         import c_int, C_CHAR
         Integer(C_INT), VALUE, Intent(IN):: cncid
         Character(KIND=C_CHAR), Intent(IN):: full_name(*)
         Integer(C_INT), Intent(ouT) :: cgrp_ncid
       End Function nc_inq_grp_full_ncid
    end Interface

    !------------------------------------------------------------

    ! We assume that the C character kind is the same as the default
    ! character kind:
    cncerr = nc_inq_grp_full_ncid(int(ncid, c_int), full_name // c_null_char, &
         cgrp_ncid)

    if (cncerr == NC_NOERR) then
       grp_ncid = cgrp_ncid
       if (present(ncerr)) ncerr = nf95_noerr
    else
       if (present(ncerr)) then
          ncerr = cncerr
       else
          call nf95_abort("nf95_inq_grp_full_ncid " // trim(full_name), &
            int(cncerr), ncid)
       end if
    end if

  end subroutine nf95_inq_grp_full_ncid

end module nf95_inq_grp_full_ncid_m

module nf95_inq_varnatts_m

  implicit none

contains

  subroutine nf95_inq_varnatts(ncid, varid, natts, ncerr)

    ! Learn how many attributes are associated with a variable.

    use, intrinsic:: ISO_C_BINDING

    use nc_constants, only: NC_NOERR
    use nf95_abort_m, only: nf95_abort

    integer, intent(in):: ncid, varid
    integer, intent(out):: natts
    integer, intent(out), optional:: ncerr

    ! Local:

    integer(C_INT) cncerr, nattsp

    Interface
       Integer(C_INT) function nc_inq_varnatts(ncid, varid, nattsp) BIND(C)
         import C_INT
         Integer(C_INT), VALUE, intent(in):: ncid, varid
         Integer(C_INT), Intent(OUT):: nattsp
       End Function nc_inq_varnatts
    End Interface

    !------------------------------------------------------------------

    cncerr = nc_inq_varnatts(int(ncid, c_int), int(varid - 1, c_int), nattsp)

    if (cncerr == nc_noerr) then
       natts = int(nattsp)
       if (present(ncerr)) ncerr = nc_noerr
    else
       if (present(ncerr)) then
          ncerr = cncerr
       else
          call nf95_abort("nf95_inq_varnatts", int(cncerr), ncid, varid)
       end if
    end if

  end subroutine nf95_inq_varnatts

end module nf95_inq_varnatts_m

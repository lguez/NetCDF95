module nf95_create_snc_m

  implicit none

contains

  subroutine nf95_create_snc(ncid, varid, var_name, dim_name, nclen)

    ! nf95_create_snc: "NetCDF95 create single no
    ! coordinate". Shortcut to create a file containing a single
    ! primary variable, without associated coordinate variables.

    use, intrinsic:: iso_fortran_env, only: error_unit

    use nf95_constants, only: NF95_CLOBBER, NF95_FLOAT
    use nf95_create_m, only: nf95_create
    use nf95_def_dim_m, only: nf95_def_dim
    use nf95_def_var_m, only: nf95_def_var

    integer, intent(out):: ncid, varid
    character(len = *), intent(in):: var_name
    character(len = *), intent(in):: dim_name(:) ! (nDimensions)
    integer, intent(in):: nclen(:) ! (nDimensions)

    ! Local:
    integer i, nDimensions
    integer dimids(size(nclen)) ! (nDimensions)

    !----------------------------------------------------------------------

    nDimensions = size(dim_name)

    if (nDimensions /= size(nclen)) then
       write(error_unit, fmt = *) "nf95_create_snc: bad input, dim_name and " &
            // "nclen must have same size"
       write(error_unit, fmt = *) "var_name = ", var_name
       write(error_unit, fmt = *) "dim_name = ", dim_name
       write(error_unit, fmt = *) "nclen = ", nclen
       stop 1
    end if

    call nf95_create(trim(var_name) // ".nc", NF95_CLOBBER, ncid)

    do i = 1, nDimensions
       call nf95_def_dim(ncid, dim_name(i), nclen(i), dimids(i))
    end do

    call nf95_def_var(ncid, var_name, NF95_FLOAT, dimids, varid)

  end subroutine nf95_create_snc

end module nf95_create_snc_m

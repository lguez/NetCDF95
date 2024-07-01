module nf95_create_single_m

  use nf95_constants, only: NF95_MAX_NAME

  implicit none

  type coord_def
     character(len = NF95_MAX_NAME) name
     integer nclen
     character(len = :), allocatable:: attr_name(:), attr_val(:)
  end type coord_def

  private NF95_MAX_NAME

contains

  subroutine nf95_create_single(name, coordinates, ncid, varid, varid_coord)

    ! Shortcut to create a file containing a single primary variable.

    use nf95_constants, only: NF95_CLOBBER, NF95_FLOAT
    use nf95_create_m, only: nf95_create
    use nf95_def_dim_m, only: nf95_def_dim
    use nf95_def_var_m, only: nf95_def_var
    use nf95_put_att_m, only: nf95_put_att

    character(len = *), intent(in):: name
    type(coord_def), intent(in):: coordinates(:)
    integer, intent(out):: ncid, varid, varid_coord(:)

    ! Local:
    integer i, j
    integer dimids(size(coordinates))

    !----------------------------------------------------------------------

    call nf95_create(name // ".nc", NF95_CLOBBER, ncid)

    do i = 1, size(coordinates)
       call nf95_def_dim(ncid, coordinates(i)%name, coordinates(i)%nclen, &
            dimids(i))
       call nf95_def_var(ncid, coordinates(i)%name, NF95_FLOAT, dimids(i), &
            varid_coord(i))

       do j = 1, size(coordinates(i)%attr_name)
          call nf95_put_att(ncid, varid_coord(i), coordinates(i)%attr_name(j), &
               coordinates(i)%attr_val(j))
       end do
    end do

    call nf95_def_var(ncid, name, NF95_FLOAT, dimids, varid)

  end subroutine nf95_create_single

end module nf95_create_single_m

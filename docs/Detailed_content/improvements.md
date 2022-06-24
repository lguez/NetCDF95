---
date: '2019-11-27'
---

# The four types of improvements

In the following documentation, we give a [description of the
interface of each NetCDF95 procedure](improvements.md). We will label
each NetCDF95 procedure with one of the following four (mutually
exclusive) mnemonics:

basic change
: Means that there is a corresponding procedure in the Fortran 90
interface and only the following three changes have been made:

-   change of the name of the procedure, `nf95_` instead of `nf90_`;
-   subroutine instead of function;
-   additional optional argument `ncerr` for error status.

Thus, for example:

    function nf90_inq_varid(ncid, name, varid)
             integer, intent(in) :: ncid
             character (len = *), intent( in) :: name
             integer, intent(out) :: varid
             integer :: nf90_inq_varid

becomes:

    subroutine nf95_inq_varid(ncid, name, varid, ncerr)
             integer, intent(in) :: ncid
             character (len = *), intent( in) :: name
             integer, intent(out) :: varid
             integer, intent(out), optional:: ncerr

Procedures with basic change: [`nf95_copy_att`](attributes.md),
[`nf95_put_att.f90`](attributes.md),
[`nf95_close`](datasets.md), [`nf95_create`](datasets.md),
[`nf95_enddef`](datasets.md),
[`nf95_inquire`](datasets.md), [`nf95_open`](datasets.md),
[`nf95_redef`](datasets.md), [`nf95_sync`](datasets.md),
[`nf95_inq_grp_full_ncid`](groups.md),
[`nf95_inq_dimid`](dimensions.md),
[`nf95_inq_varid`](variables.md)

interface change
: Means that there is a corresponding procedure in the Fortran 90
interface, and the interface of the procedure has been changed beyond
the "basic" change described above, but there is no change in
functionality.

Procedures with interface change:
[`nf95_def_dim`](dimensions.md),
[`nf95_inquire_dimension`](dimensions.md),
[`nf95_def_var`](variables.md) and
[`nf95_def_var_scalar`](variables.md),
[`nf95_inquire_attribute`](attributes.md),
[`nf95_inq_grpname`](groups.md),
[`nf95_inq_grpname_full`](groups.md),
[`nf95_inq_grps`](groups.md)

functionality change
: Means that there is a corresponding procedure in the Fortran 90
interface, the interface of the procedure has been changed and the
functionality has also been improved.

Procedures with functionality change:
[`nf95_get_var`](variables.md),
[`nf95_inquire_variable`](variables.md),
[`nf95_put_var`](variables.md),
[`nf95_get_att`](attributes.md)

additional procedure
: Means there is no corresponding procedure in the Fortran 90 interface.

Additional procedures: [`handle_err`](datasets.md),
[`nf95_gw_var`](variables.md),
[`find_coord`](datasets.md),
[`nf95_get_missing`](attributes.md),
[`nf95_create_single`](datasets.md)

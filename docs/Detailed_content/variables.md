# Variables

This page describles procedures handling NetCDF variables.

See the [improvements page](improvements.md) for an explanation of
the mnemonics "basic change", "interface change", "functionality
change", "additional procedure".

## Reminder on allocatable arguments

Some NetCDF95 procedures below have a dummy argument with attributes
allocatable and `intent(out)`. Recall that in this case the associated
actual argument must also have the allocatable attribute. If it is
allocated before the call, it will automatically be deallocated and
reallocated in the NetCDF95 procedure.

## `nf95_def_var` and `nf95_def_var_scalar`

(interface change)

```
subroutine nf95_def_var_scalar(ncid, name, xtype, varid, ncerr)
  integer,               intent( in) :: ncid
  character (len = *),   intent( in) :: name
  integer,               intent( in) :: xtype
  integer,               intent(out) :: varid
 integer, intent(out), optional:: ncerr
```

```
subroutine nf95_def_var(ncid, name, xtype, dimids, varid, ncerr)
  integer,               intent( in) :: ncid
  character (len = *),   intent( in) :: name
  integer,               intent( in) :: xtype
  integer[, dimension(:)], intent( in) :: dimids
  integer,               intent(out) :: varid
  integer, intent(out), optional:: ncerr
```

(`dimids` may be either a scalar or a rank 1 array.)

Because of the additional optional argument `ncerr`, the generic
procedure name `nf95_def_var` cannot include the case of a scalar
variable. So there is a specific public procedure `nf95_def_var_scalar`
for this case.

Reference:
[`nf90_def_var`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-variables.html#f90-create-a-variable-nf90_def_var)

## `nf95_get_var`

(functionality change)

```
subroutine nf95_get_var(ncid, varid, values, start, &
     new_missing, ncerr)

  integer, intent(in) :: ncid, varid
  any type, intent(out):: values
  integer, dimension(:), optional, intent(in):: start
  same type as values, optional, intent(in):: new_missing
  integer, intent(out), optional:: ncerr
```

(if argument `values` is a scalar then arguments `count_nc`, stride and map
must not be present)

or

```
subroutine nf95_get_var(ncid, varid, values, start, &
     count_nc, stride, map, new_missing, ncerr)

  integer, intent(in) :: ncid, varid
  any type and any rank >= 1, intent(out):: values
  integer, dimension(:), optional, intent(in):: start, count_nc, stride, map
  same type as values, optional, intent(in):: new_missing
  integer, intent(out), optional:: ncerr
```

(if argument `values` is an array then arguments `count_nc`, stride and
map may be present)

The argument for the number of indices selected along each dimension is
called `count_nc` in `nf95_get_var`, instead of `count` in
`nf90_get_var`. `count` is not a good choice for a variable name because
it is the name of a Fortran intrinsic procedure.

`nf95_get_var` checks that :

-   the size of arguments `start` and `count_nc` equals the rank of the
    NetCDF variable ;
-   if `count_nc` is absent, the rank of argument `values` is lower than
    or equal to the rank of the NetCDF variable.

There is an optional argument, `new_missing`, which is not in the
[Fortran 90 NetCDF
interface](https://www.unidata.ucar.edu/software/netcdf/docs-fortran/f90_The-NetCDF-Fortran-90-Interface-Guide.html). If
the argument `new_missing` is present then, in the returned `values`,
the missing value from the NetCDF variable is replaced by
`new_missing`.  This may be useful for example if, in your program,
you need the missing value to be `ieee_value(0., IEEE_QUIET_NAN)`
rather than `NF90_FILL_REAL`.

Reference:
[`nf90_get_var`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-variables.html#f90-reading-data-values-nf90_get_var)

## `nf95_gw_var`

(additional procedure)

      subroutine nf95_gw_var(ncid, varid, values)
        integer, intent(in):: ncid
        integer, intent(in):: varid
        any type and kind, any rank, allocatable, intent(out):: values

`nf95_gw_var` stands for "NetCDF95 get whole variable". This
procedure reads a whole NetCDF variable into an array. When you want all
the values of the NetCDF variable, this procedure is a shortcut to:
inquiring about the dimension IDs of the variable, inquiring about the
length of each dimension found, allocating the Fortran variable, reading
the values from the NetCDF variable.

The procedure checks that the rank of the argument `values` equals the
rank of the NetCDF variable. The procedure does not require nor check
that the type of `values` corresponds to the type of the NetCDF
variable: conversion will occur if necessary.

See [reminder on allocatable arguments](#reminder-on-allocatable-arguments).

## `nf95_inq_varid`

(basic change)

      subroutine nf95_inq_varid(ncid, name, varid, ncerr)
        integer,             intent(in) :: ncid
        character (len = *), intent(in) :: name
        integer,             intent(out) :: varid
        integer, intent(out), optional:: ncerr

Reference:
[`nf90_inq_varid`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-variables.html#f90-get-the-id-of-a-variable-from-the-name-nf90_inq_varid)

## `nf95_inq_varnatts`

(additional procedure)

	 subroutine nf95_inq_varnatts(ncid, varid, natts, ncerr)
	   integer, intent(in):: ncid, varid
       integer, intent(out):: natts
       integer, intent(out), optional:: ncerr

This procedure tells you how many attributes a variable has, knowing
the variable ID. You can call it with `varid = nf95_global` to find
out the number of global attributes.

Strangely, although a procedure `nf90_inq_varnatts` is mentioned in
the documentation of [`nf90_inquire_attribute` and
`nf90_inq_attname`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-attributes.html#f90-get-information-about-an-attribute-nf90_inquire_attribute-and-nf90_inq_attname),
this procedure does not exist in the Fortran 90 NetCDF interface. So
it seems the only way to get the number of attributes with the Fortran
90 NetCDF interface is to loop on `nf90_inq_attname` until it returns
an error.

Reference: [`nc_inq_varnatts`](https://docs.unidata.ucar.edu/netcdf-c/current/group__variables.html#ga4df3b5bbf48e98cbd6847bd24f072ec8)

## `nf95_inquire_variable`

(functionality change)

      subroutine nf95_inquire_variable(ncid, varid, name, xtype, ndims, dimids, &
           nAtts, ncerr)
        integer, intent(in):: ncid, varid
        character(len = *), optional, intent(out):: name
        integer, optional, intent(out) :: xtype, ndims
        integer, dimension(:), optional, allocatable, intent(out) :: dimids
        integer, optional, intent(out) :: nAtts
        integer, intent(out), optional :: ncerr

In the "new" `nf95_inquire_variable`, the argument `dimids` has the
allocatable attribute. The procedure `nf95_inquire_variable` allocates
and defines `dimids` if the argument is present. `dimids` is defined as
a zero-sized array if the NetCDF variable is a scalar with no dimension.

In the "old" `nf90_inquire_variable`, `dimids` was an assumed-size
array. This was Fortran 77 style, not optimal. You had to allocate
`dimids` in the calling procedure with a maximum possible number of
dimensions. You also needed to call `nf90_inquire_variable` with the
argument `ndims` present, to tell you which part of `dimids` was
defined.

See [reminder on allocatable arguments](#reminder-on-allocatable-arguments).

Reference:
[`nf90_inquire_variable`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-variables.html#f90-get-information-about-a-variable-from-its-id-nf90_inquire_variable)

## `nf95_put_var`

(functionality change)

```
subroutine nf95_put_var(ncid, varid, values, start, ncerr)
  integer,                         intent(in) :: ncid, varid
  any type and any kind, intent(in) :: values
  integer, dimension(:), optional, intent(in) :: start
  integer, intent(out), optional:: ncerr
```

(If argument `values` is a scalar then arguments `count_nc`, stride and map
must not be present.)

Or:

```
subroutine nf95_put_var(ncid, varid, values, start, count_nc, stride, map, ncerr)
  integer,                         intent(in) :: ncid, varid
  any type and any kind, any rank >= 1, intent(in) :: values
  integer, dimension(:), optional, intent(in) :: start, count_nc, stride, map
  integer, intent(out), optional:: ncerr
```

(If argument `values` is an array then arguments `count_nc`, stride and
map may be present.)

The argument for the number of indices selected along each dimension is
called `count_nc` in `nf95_put_var`, instead of `count` in
`nf90_put_var`. `count` is not a good choice for a variable name because
it is the name of a Fortran intrinsic procedure.

`nf95_put_var` checks that :

-   the size of arguments `start` and `count_nc` equals the rank of the
    NetCDF variable ;
-   if `count_nc` is absent, the rank of argument `values` is lower than
    or equal to the rank of the NetCDF variable.

Reference:
[`nf90_put_var`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-variables.html#f90-writing-data-values-nf90_put_var)

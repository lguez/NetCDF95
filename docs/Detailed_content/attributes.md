# Attributes

This page describles procedures handling NetCDF attributes.

See the [improvements page](improvements.md) for an explanation of
the mnemonics "basic change", "interface change", "functionality
change", "additional procedure".

## `nf95_copy_att`

(basic change)

      subroutine nf95_copy_att(ncid_in, varid_in, name, ncid_out, varid_out, ncerr)
        integer, intent( in):: ncid_in,  varid_in
        character(len=*), intent( in):: name
        integer, intent( in):: ncid_out, varid_out
        integer, intent(out), optional:: ncerr

Reference:
[`nf90_copy_att`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-attributes.html#f90-copy-attribute-from-one-netcdf-to-another-nf90_copy_att)

## `nf95_get_att`

(functionality change)

      subroutine nf95_get_att(ncid, varid, name, values, ncerr)
        integer,                          intent( in) :: ncid, varid
        character(len = *),               intent( in) :: name
        character(len = *), integer(any kind) or real(any kind), intent(out) :: values
        integer, intent(out), optional:: ncerr

`nf95_get_att` is more secure than `nf90_get_att`. For an argument
`values` of type `character`, `nf95_get_att` checks that the `values`
argument is long enough and removes the null terminator, if any. For a
numeric scalar `values` argument, `nf95_get_att` checks that the
attribute contains a single value.

Reference:
[`nf90_get_att`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-attributes.html#f90-get-attributes-values-nf90_get_att)

## `nf95_get_missing`

(additional procedure)

```
subroutine nf95_get_missing(ncid, varid, missing)

  integer, intent(in)::  ncid, varid
  
  real or double precision or integer, of any kind, or character, intent(out):: missing
  ! missing or fill value
```

The procedure returns the `missing_value` or `_FillValue` attribute if
one of them is present, else the `nf95_fill_type` constant
corresponding to the type of argument `missing`. If both
`missing_value` and `_FillValue` are present then the procedure checks
that they are equal.

If the type of the `missing_value` or `_FillValue` attribute is
different than the type of argument `missing` then conversion will
occur. The procedure prints a warning as this is dangerous
usage. Indeed, if you read values of the corresponding NetCDF variable
without conversion then the converted missing value from the attribute
may not correspond to the un-converted value in the NetCDF
variable. And if you read values of the NetCDF variable with the same
conversion as for the attribute, then values which are valid but close
to the missing value in the NetCDF variable may become equal to the
missing value after conversion. See the (admittedly contrived)
examples in file `Tests/test_get_missing.f90` which demonstrate this
risk. Concluding advice: if you convert missing value from double
precision real to single precision real, for example, be sure to
convert also values of the NetCDF variable, and make sure that there
are no values close to the missing value in the NetCDF variable.

## `nf95_inq_attname`

(interface change)

```
subroutine nf95_inq_attname(ncid, varid, attnum, name, ncerr)

  integer, intent(in):: ncid, varid, attnum
  character(len = :), allocatable, intent(out):: name
  integer, intent(out), optional:: ncerr
```

The argument name has dynamic (deferred) length in `nf95_inq_attname`
instead of assumed length in `nf90_inq_attname`. So you do not have to
worry about a maximum length for the corresponding actual argument:
just declare it also as `character(len = :), allocatable`.

## `nf95_inquire_attribute`

(interface change)

```
subroutine nf95_inquire_attribute(ncid, varid, name, xtype, nclen, attnum, &
     ncerr)

  integer, intent( in)     :: ncid, varid
  character (len = *), intent( in)     :: name
  integer, intent(out), optional :: xtype, nclen, attnum
  integer, intent(out), optional:: ncerr
```

The argument for the number of values or characters of the attribute is
called `nclen` in `nf95_inquire_attribute`, instead of `len` in
`nf90_inquire_attribute`. `len` is not a good choice for a variable name
because it is the name of a Fortran intrinsic procedure.

Reference:
[`nf90_inquire_attribute`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-attributes.html#f90-get-information-about-an-attribute-nf90_inquire_attribute-and-nf90_inq_attname)

## `nf95_put_att`

(basic change)

```
subroutine nf95_put_att(ncid, varid, name, values, ncerr)
  integer, intent(in) :: ncid, varid
  character(len = *), intent(in) :: name
  character(len = *) or integer(any kind) or real(any kind), intent(in) :: values
  integer, intent(out), optional:: ncerr
```

Reference:
[`nf90_put_att`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90-attributes.html#f90-create-an-attribute-nf90_put_att)

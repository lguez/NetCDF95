---
date: '2022-06-24'
---

# Introduction

## What is it?

NetCDF95 is an alternative Fortran interface to the
[NetCDF](http://www.unidata.ucar.edu/software/netcdf/index.html)
library. The official Fortran interface is the [Fortran 90 NetCDF
interface](https://www.unidata.ucar.edu/software/netcdf/docs-fortran/f90_The-NetCDF-Fortran-90-Interface-Guide.html).

The name NetCDF95 was at first a reference to the Fortran 95 standard
but NetCDF95 now uses Fortran 2003 features.

Author: [Lionel GUEZ](https://www.lmd.jussieu.fr/~lguez)

## Why an alternative interface?

Compared to the the [Fortran 90 NetCDF
interface](https://www.unidata.ucar.edu/software/netcdf/docs-fortran/f90_The-NetCDF-Fortran-90-Interface-Guide.html),
NetCDF95 is meant to be friendlier and more secure. Notably:

- NetCDF95 frees you of the cumbersome task of handling the error
status.  NetCDF95 procedures behave like the Fortran input/output
statements. That is, the error status is an optional output
argument. Consider, for example, the Fortran formatted `read`
statement:
```
read([unit=]u, [fmt=]fmt [,iostat=ios] [, err=error-label] &
[,end=end-label]) [list]
```
If the `err`, `end` and `iostat` keywords are not provided, and there
is a problem in the execution of the `read` statement, then execution
of the program stops (with an informative error message from the
compiler). Similarly, NetCDF95 procedures have an optional argument
for error status. If the optional argument is absent and there is an
error, then the NetCDF95 procedure produces an error message and stops
the program. (The official Fortran 90 interface looks like it has been
made to mimic the C interface, and this is not optimal in Fortran.)

- NetCDF95 frees you of assumptions on the size of arrays and the size
  of character strings when you call several inquiry procedures. (It
  does so by making use of allocatable arguments, a Fortran 2003
  feature.) See
  [`nf95_inquire_variable`](Detailed_content/variables.md),
  [`nf95_inq_grpname`](Detailed_content/groups.md),
  [`nf95_inq_grps`](Detailed_content/groups.md),
  [`nf95_inq_grpname_full`](Detailed_content/groups.md).
  
- NetCDF95 offers procedures that have no counterpart in the official
  interface. These combine several calls to other NetCDF95 procedures
  for common higher-level tasks. See
  [`nf95_gw_var`](Detailed_content/variables.md),
  [`nf95_find_coord`](Detailed_content/datasets.md),
  [`nf95_create_single`](Detailed_content/datasets.md),
  [`nf95_get_missing`](Detailed_content/attributes.md).
  
- NetCDF95 replaces functions by subroutines. Procedures of the
official Fortran 90 interface are all functions, and they are all with
side effects. First, they have `intent(out)` arguments. Furthermore,
there is obviously data transfer inside the procedures. Any data
transfer inside a function is considered as a side effect. In this
respect, the Fortran 90 interface mimics the C interface. But Fortran
has a different programming style than C and frowns upon side-effects
in functions. See for example Metcalf and Reid (Fortran 90/95
Explained, 1999, §§ 5.10 and 6.10).

- There are other improvements such as securing the call to
[`nf95_get_var`](Detailed_content/variables.md) by checking the
arguments start and `count_nc`, and renaming badly chosen argument
names len and count to nclen and `count_nc`.

  

# Groups

This page describles procedures handling NetCDF groups.

See the [improvements page](improvements.md) for an
explanation of the mnemonics \"basic change\", \"interface change\",
\"functionality change\", \"additional procedure\".

## `nf95_inq_file_ncid`

(additional procedure)

```
subroutine nf95_inq_file_ncid(ncid_file, grpid, ncerr)

  ! Find the ncid of the file (that is, the root group), knowing the
  ! ncid of a group in the file.

  integer, intent(out):: ncid_file
  integer, intent(in):: grpid
  integer, intent(out), optional:: ncerr
```

## `nf95_inq_grp_full_ncid`

(basic change)

```
subroutine nf95_inq_grp_full_ncid(ncid, full_name, grp_ncid, ncerr)

  integer, intent(in):: ncid ! can be the file id or a group id

  character(len = *), intent(in):: full_name
  ! Should be a path relative to ncid (which can correspond to the
  ! root group or a subgroup). Can be an immediate subgroup or a
  ! deeper subgroup.

  integer, intent(out):: grp_ncid
  integer, intent(out), optional:: ncerr
```

You know the relative path of a group and you want its ncid.

Reference:
[`nc_inq_grp_full_ncid`](https://docs.unidata.ucar.edu/netcdf-c/current/group__groups.html#ga41d2e214f1a880493ed8ea3fbddab806)

## `nf95_inq_grpname`

(functionality change)

```
subroutine nf95_inq_grpname(ncid, name, ncerr)

  integer, intent(in):: ncid ! can be the file id or a group id
  character(len = :), allocatable, intent(out):: name ! without path
  integer, intent(out), optional:: ncerr
```

You know the ncid of a group (which can be the root group) and you
want the basename of this group. The basename of the group is the last
part in the absolute path, as in the Unix basename program. The
basename of the root group is "/".

The functionality change is that the argument `name` has dynamic,
deferred length.

The problem with the Fortran 90 interface: `name` has assumed length
in the Fortran 90 interface. Also, there is no way in the Fortran 90
interface to only inquire about the length of the name. The function
`nf90_inq_grpname_len` gives the length of the absolute path of the
group, not the length of the basename of the group.

Reference:
[`nf90_inq_grpname`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90_groups.html#f90-find-a-groups-name-nf90_inq_grpname)

## `nf95_inq_grpname_full`

(functionality change)

```
subroutine nf95_inq_grpname_full(ncid, full_name, ncerr)

  integer, intent(in):: ncid
  character(len = :), allocatable, intent(out):: full_name ! absolute path
  integer, intent(out), optional:: ncerr
```

You know the ncid of a group (which can be the root group) and you
want the absolute path of the group.

The functionality change is that the argument `full_name` has dynamic,
deferred length, and there is no length argument. Since `full_name` is
allocated to the exact length of the path, the length argument is
useless, you can just query the length of the actual argument after
the call.

The problem with the Fortran 90 interface: the name argument has assumed length
in the Fortran 90 interface. You have to call `nf90_inq_grpname_len`
first to know the length of the actual argument that you will
associate to name.

Reference:
[`nf90_inq_grpname_full`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90_groups.html#f90-find-a-groups-full-name-nf90_inq_grpname_full)

## `nf95_inq_grp_parent`

(basic change)

```
subroutine nf95_inq_grp_parent(ncid, parent_ncid, ncerr)

  integer, intent(in):: ncid
  integer, intent(out):: parent_ncid
  integer, intent(out), optional:: ncerr
```

You know the ncid of a group and you want the ncid of the parent
group.

## `nf95_inq_grps`

(functionality change)

```
subroutine nf95_inq_grps(ncid, ncids, ncerr)

  integer, intent(in):: ncid ! can be the file id or a group id
  integer, allocatable, intent(out):: ncids(:)
  integer, intent(out), optional:: ncerr
```

You know the ncid of a group (which can be the root group) and you
want the ncids of its immediate subgroups.

The functionality change is that the argument ncids is allocatable and
there is no argument numgrps. Since ncids is allocated to the number
of groups, the argument numgrps is useless, you can just query the
size of the actual argument associated to ncids after the call.

The problem with the Fortran 90 interface: ncids has assumed shape in
the Fortran 90 interface. Also, there is no way in the Fortran 90
interface to only inquire about the number of subgroups. The Fortran
90 interface is dangerous here because it does not check that the size
of ncids is large enough: a segmentation violation will occur if it is
not. NetCDF95 solves this by going directly to the C interface.

Reference:
[`nf90_inq_grps`](https://docs.unidata.ucar.edu/netcdf-fortran/current/f90_groups.html#f90-get-a-list-of-groups-in-a-group-nf90_inq_grps)
and
[`nc_inq_grps`](https://docs.unidata.ucar.edu/netcdf-c/current/group__groups.html#ga33eb934cc6810770be78eaa822656a00)


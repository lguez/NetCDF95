# Handling of errors

If you call a NetCDF95 procedure without the optional `ncerr`
argument, and some error occurs, then the NetCDF95 procedure will:

-   write to standard output all the information it has, including the
    string produced by `nf90_strerror`;
-   try to close the NetCDF file;
-   stop the program, with an exit status of 1.

For example, if some error occurs within a call to `nf95_inq_varid`,
`nf95_inq_varid` will write to standard output:

    nf95_inq_varid, name = < name of the variable you inquired about >:
    < string produced by nf90_strerror >

## `nf95_abort`

(additional procedure)

```
subroutine nf95_abort(message, ncerr, ncid, varid)
  character(len=*), intent(in):: message
  ! (should include name of calling procedure)

  integer, intent(in):: ncerr

  integer, intent(in), optional :: ncid
  ! This can be the file ncid or a group ncid. Provide this argument
  ! if you want nf95_abort to try to close the file.

  integer, intent(in), optional :: varid
```

This is a public procedure which is also used internally in NetCDF95.
`nf95_abort` prints a message and stops the program. `nf95_abort` may
also be useful after calling procedures of the Fortran 90 interface
that have not been implemented in NetCDF95.

You should include the name of the calling procedure in the `message`
argument. Provide the `ncid` argument if you want `nf95_abort` to try
to close the file. Provide `varid` if you want `nf95_abort` to print
it.

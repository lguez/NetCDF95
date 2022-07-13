module nc_inq_grpname_len_m

  implicit none

  Interface
     Integer(C_INT) Function nc_inq_grpname_len(ncid, lenp) BIND(C)
       use, intrinsic:: ISO_C_BINDING
       Integer(C_INT), VALUE, intent(in):: ncid

       Integer(C_SIZE_T), Intent(OUT):: lenp
       ! This is the length of the full name (the absolute path), not
       ! just the length of the basename. It does not count the NULL
       ! terminator.
     End Function nc_inq_grpname_len
  End Interface

end module nc_inq_grpname_len_m

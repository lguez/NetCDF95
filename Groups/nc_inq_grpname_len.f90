module nc_inq_grpname_len_m

  implicit none

  Interface
     Integer(C_INT) Function nc_inq_grpname_len(ncid, lenp) BIND(C)
       use, intrinsic:: ISO_C_BINDING
       Integer(C_INT), VALUE, intent(in):: ncid

       Integer(C_SIZE_T), Intent(OUT):: lenp
       ! does not include NULL terminator
     End Function nc_inq_grpname_len
  End Interface

end module nc_inq_grpname_len_m

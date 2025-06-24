module strlen_m

  implicit none

  interface
     INTEGER(C_INT) function strlen(str) bind(c)
       use, intrinsic:: iso_c_BINDING
       TYPE(c_ptr), intent(in), value:: str
     end function strlen
  end interface

end module strlen_m

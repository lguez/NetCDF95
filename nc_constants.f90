module nc_constants

  use, intrinsic:: ISO_C_BINDING, only: c_int

  implicit none

  Integer(C_INT), Parameter:: NC_NOERR = 0
  Integer(C_INT), Parameter:: NC_ENOGRP = - 125 ! no group found
  Integer(C_INT), Parameter:: NC_ENOTVAR = -49 ! variable not found

  private c_int

end module nc_constants

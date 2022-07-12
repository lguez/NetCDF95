module nf95_constants

  use nc_constants, only: NC_NOERR, NC_ENOGRP

  implicit none

  Integer, Parameter:: Nf95_NOERR = NC_NOERR
  Integer, Parameter:: Nf95_ENOGRP = NC_ENOGRP

  private NC_NOERR, NC_ENOGRP

end module nf95_constants

program test_c_char

  ! We assume (and do not check) that the C character kind is the same
  ! as the default character kind in nf95_inq_grpname and
  ! nf95_inq_grp_full_ncid.

  use, intrinsic:: ISO_C_BINDING

  implicit none

  !------------------------------------------------------------------------

  if (kind("a") /= c_char) then
     print *, "Bad assumption: default character kind is not C character kind"
     stop 1
  end if

end program test_c_char
module type_sizes

  ! Copied from netcdf-fortran 4.6.1.
  ! Written by Robert Pincus

  ! Provide named kind parameters for use in declarations of real and
  ! integer variables with specific byte sizes (i.e. one, two, four,
  ! and eight byte integers; four and eight byte reals). The
  ! parameters can then be used in (KIND = XX) modifiers in
  ! declarations.

  implicit none

  integer, parameter:: OneByteInt = selected_int_kind(2), &
       TwoByteInt = selected_int_kind(4), FourByteInt = selected_int_kind(9), &
       EightByteInt = selected_int_kind(18)
  integer, parameter:: FourByteReal = selected_real_kind(P = 6, R = 37), &
       EightByteReal = selected_real_kind(P = 13, R = 307)

contains

  logical function byteSizesOK()

    ! Users may call this function once to ensure that the kind
    ! parameters the module defines correspond to the right number of
    ! bytes. We can't ensure that the two REAL kinds are actually four
    ! and eight bytes long.

    !-----------------------------------------------------------------------

    byteSizesOK = bit_size(0_OneByteInt) == 8 &
         .and. bit_size(0_TwoByteInt) == 16 &
         .and. bit_size(0_FourByteInt) == 32 &
         .and. bit_size(0_EightByteInt) == 64

  end function byteSizesOK

end module type_sizes

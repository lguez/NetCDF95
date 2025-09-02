module nf95_inq_libvers_m

  Implicit NONE

contains

  subroutine nf95_inq_libvers

    ! Print versions of NetCDF95 and NetCDF-C libraries.

    use, intrinsic:: ISO_C_BINDING

    ! Local:
    Character, Pointer :: c_lib_version(:)
    type(c_ptr) p_version

    interface
       TYPE(c_ptr) function nc_inq_libvers() bind(c)
         import c_ptr
       end function nc_inq_libvers

       INTEGER(C_INT) function strlen(str) bind(c)
         import c_ptr, c_int
         TYPE(c_ptr), intent(in), value:: str
       end function strlen
    end interface

    !----------------------------------------------------------------------

    p_version = nc_inq_libvers()
    Call C_F_POINTER(p_version, c_lib_version, shape = [strlen(p_version)])
    print *, "Version v0.13 of NetCDF95"
    print *, "Compiled with NetCDF-C library version: ", c_lib_version

  End subroutine nf95_inq_libvers

end module nf95_inq_libvers_m

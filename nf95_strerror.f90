module nf95_strerror_m

  implicit none

contains

  function nf95_strerror(ncerr)

    use, intrinsic:: iso_c_BINDING

    use strlen_m, only: strlen

    character(len = :), allocatable:: nf95_strerror
    integer, intent(in):: ncerr

    ! Local:

    interface
       type(c_ptr) function nc_strerror(ncerr1) bind(c)
         import c_ptr, c_int
         integer(c_int), intent(in), value:: ncerr1
       end function nc_strerror
    end interface

    type(c_ptr) pointer_strerror
    integer len_strerror, i
    character, pointer:: array_strerror(:)

    !----------------------------------------------------------------------

    pointer_strerror = nc_strerror(int(ncerr, c_int))
    len_strerror = strlen(pointer_strerror)
    call c_f_pointer(pointer_strerror, array_strerror, shape = [len_strerror])
    allocate(character(len = len_strerror):: nf95_strerror)

    do i = 1, len_strerror
       nf95_strerror(i:i) = array_strerror(i)
    end do

  end function nf95_strerror

end module nf95_strerror_m

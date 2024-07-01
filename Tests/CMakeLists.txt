cmake_minimum_required(VERSION 3.16...3.27)
project(NetCDF95_tests LANGUAGES Fortran)
find_package(NetCDF_Fortran REQUIRED)

if(NOT TARGET netcdf95)
  find_package(NetCDF95 CONFIG REQUIRED)
endif()

# test_netcdf95
add_executable(test_netcdf95 test_netcdf95.f90)
target_link_libraries(test_netcdf95 PRIVATE NetCDF_Fortran::netcdff)

# test_put_var_char
add_executable(test_put_var_char test_put_var_char.f90)
target_link_libraries(test_put_var_char PRIVATE NetCDF_Fortran::netcdff)

# test_get_missing_char
add_executable(test_get_missing_char test_get_missing_char.f90)
target_link_libraries(test_get_missing_char PRIVATE NetCDF_Fortran::netcdff)

# test_get_var_text
add_executable(test_get_var_text test_get_var_text.f90)
target_link_libraries(test_get_var_text PRIVATE NetCDF_Fortran::netcdff)

# test_inq_grp_full_ncid
add_executable(test_inq_grp_full_ncid test_inq_grp_full_ncid.f90)
target_link_libraries(test_inq_grp_full_ncid PRIVATE NetCDF_Fortran::netcdff)

# test_inq_grpname
add_executable(test_inq_grpname test_inq_grpname.f90)
target_link_libraries(test_inq_grpname PRIVATE NetCDF_Fortran::netcdff)

add_executable(test_abort test_abort.f90)
add_executable(test_inq_grps test_inq_grps.f90)
add_executable(test_inq_file_ncid test_inq_file_ncid.f90)
add_executable(test_create_single test_create_single.f90)
add_executable(test_inq_varnatts test_inq_varnatts.f90)
add_executable(test_inq_attname test_inq_attname.f90)
add_executable(test_get_att_text test_get_att_text.f90)

foreach(my_exe IN ITEMS test_netcdf95 test_abort test_put_var_char
    test_get_missing_char test_get_var_text test_inq_grp_full_ncid
    test_inq_grps test_inq_grpname test_inq_file_ncid test_create_single
    test_inq_varnatts test_inq_attname test_get_att_text)
  target_link_libraries(${my_exe} PRIVATE NetCDF95::netcdf95)
endforeach()

cmake_minimum_required(VERSION 3.16...3.27)
project(NetCDF95_tests LANGUAGES Fortran)
enable_testing()
find_package(NetCDF_Fortran REQUIRED)

if(NOT TARGET netcdf95)
  find_package(NetCDF95 CONFIG REQUIRED)
endif()

set(test_list abort c_char create_single find_coord get_att_text
   get_missing get_missing_2 get_var_text gunp_var inq_attname
   inq_file_ncid inq_grp_full_ncid inq_grpname inq_grps inq_varnatts
   netcdf95 put_var_char)

foreach(my_test IN LISTS test_list)
  add_executable(test_${my_test} test_${my_test}.f90)
  target_link_libraries(test_${my_test} PRIVATE NetCDF95::netcdf95)
endforeach()

target_link_libraries(test_put_var_char PRIVATE NetCDF_Fortran::netcdff)
target_link_libraries(test_inq_grp_full_ncid PRIVATE NetCDF_Fortran::netcdff)

# test_get_missing_2
add_test(NAME get_missing_2 COMMAND test_get_missing_2 WORKING_DIRECTORY
  ${CMAKE_CURRENT_LIST_DIR})
set_tests_properties(get_missing_2 PROPERTIES WILL_FAIL true)

add_test(NAME default_c_char COMMAND test_c_char)

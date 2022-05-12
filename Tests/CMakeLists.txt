# test_netcdf95
add_executable(test_netcdf95 test_netcdf95.f90)
target_link_libraries(test_netcdf95 PRIVATE netcdf95 NetCDF_Fortran::netcdff)

# test_handle_err
add_executable(test_handle_err test_handle_err.f90)
target_link_libraries(test_handle_err PRIVATE netcdf95)

# test_put_var_char
add_executable(test_put_var_char test_put_var_char.f90)
target_link_libraries(test_put_var_char PRIVATE NetCDF_Fortran::netcdff
  netcdf95)

# test_get_missing_char
add_executable(test_get_missing_char test_get_missing_char.f90)
target_link_libraries(test_get_missing_char PRIVATE NetCDF_Fortran::netcdff
  netcdf95)

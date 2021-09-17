add_executable(test_netcdf95 test_netcdf95.f90)

target_link_libraries(test_netcdf95 PRIVATE netcdf95
  NetCDF_Fortran::NetCDF_Fortran)

add_executable(test_handle_err test_handle_err.f90)
target_link_libraries(test_handle_err PRIVATE netcdf95)

# test_netcdf95
add_executable(test_netcdf95 test_netcdf95.f90)
target_link_libraries(test_netcdf95 PRIVATE netcdf95 NetCDF_Fortran::netcdff)

# test_abort
add_executable(test_abort test_abort.f90)
target_link_libraries(test_abort PRIVATE netcdf95)

# test_put_var_char
add_executable(test_put_var_char test_put_var_char.f90)
target_link_libraries(test_put_var_char PRIVATE NetCDF_Fortran::netcdff
  netcdf95)

# test_get_missing_char
add_executable(test_get_missing_char test_get_missing_char.f90)
target_link_libraries(test_get_missing_char PRIVATE NetCDF_Fortran::netcdff
  netcdf95)

# test_get_var_text
add_executable(test_get_var_text test_get_var_text.f90)
target_link_libraries(test_get_var_text PRIVATE NetCDF_Fortran::netcdff
  netcdf95)

# test_inq_grp_full_ncid
add_executable(test_inq_grp_full_ncid test_inq_grp_full_ncid.f90)
target_link_libraries(test_inq_grp_full_ncid PRIVATE NetCDF_Fortran::netcdff
  netcdf95)

# test_inq_grps
add_executable(test_inq_grps test_inq_grps.f90)
target_link_libraries(test_inq_grps PRIVATE NetCDF_Fortran::netcdff netcdf95)

# test_inq_grpname
add_executable(test_inq_grpname test_inq_grpname.f90)
target_link_libraries(test_inq_grpname PRIVATE NetCDF_Fortran::netcdff netcdf95)

# test_inq_file_ncid
add_executable(test_inq_file_ncid test_inq_file_ncid.f90)
target_link_libraries(test_inq_file_ncid PRIVATE netcdf95)

# test_create_single
add_executable(test_create_single test_create_single.f90)
target_link_libraries(test_create_single PRIVATE netcdf95)

# test_inq_varnatts
add_executable(test_inq_varnatts test_inq_varnatts.f90)
target_link_libraries(test_inq_varnatts PRIVATE netcdf95)

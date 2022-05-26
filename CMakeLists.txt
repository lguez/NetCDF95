cmake_minimum_required(VERSION 3.16)
list(APPEND CMAKE_MESSAGE_CONTEXT NetCDF95)
project(NetCDF95 LANGUAGES Fortran C)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release Profile)
add_library(netcdf95 check_start_count.f90 find_coord.f90
  handle_err.f90 netcdf95.f90 nf95_close.f90 nf95_copy_att.f90
  nf95_create.f90 nf95_def_dim.f90 nf95_def_var.f90 nf95_enddef.f90
  nf95_get_att.f90 nf95_get_missing.f90 nf95_get_var.f90
  nf95_gw_var.f90 nf95_inq_dimid.f90 nf95_inquire_attribute.f90
  nf95_inquire_dimension.f90 nf95_inquire.f90
  nf95_inquire_variable.f90 nf95_inq_varid.f90 nf95_open.f90
  nf95_put_att.f90 nf95_put_var.f90 nf95_redef.f90 nf95_sync.f90
  nf95_get_var_scalar.h nf95_get_var_array.h nf95_create_single.f90
  nf95_inq_grp_full_ncid.f90 nf95_inq_grpname_full.f90
  nf95_inq_grps.f90 inq_numgrps.c)
set_target_properties(netcdf95 PROPERTIES Fortran_MODULE_DIRECTORY
  ${PROJECT_BINARY_DIR}/modules)
target_include_directories(netcdf95 PUBLIC
  $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/modules>)

if(CMAKE_Fortran_COMPILER_ID MATCHES NAG)
  target_include_directories(netcdf95 PRIVATE ${CMAKE_CURRENT_LIST_DIR})
endif()

find_package(netCDF REQUIRED)
find_package(NetCDF_Fortran REQUIRED)
target_link_libraries(netcdf95 PRIVATE NetCDF_Fortran::netcdff netCDF::netcdf)
add_subdirectory(Tests)
add_library(${PROJECT_NAME}::netcdf95 ALIAS netcdf95)
configure_file(${PROJECT_NAME}Config.cmake.in ${PROJECT_NAME}Config.cmake @ONLY)

# Start installation part

if(CMAKE_Fortran_COMPILER_ID MATCHES NAG|Intel|PGI)
  set(install_include_dir include/${PROJECT_NAME})

  install(DIRECTORY ${PROJECT_BINARY_DIR}/modules/ DESTINATION
    ${install_include_dir})

else()
  set(install_include_dir include)
  install(FILES ${PROJECT_BINARY_DIR}/modules/netcdf95.mod TYPE INCLUDE)
endif()

install(TARGETS netcdf95 EXPORT ${PROJECT_NAME}Targets INCLUDES
  DESTINATION ${install_include_dir})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  DESTINATION lib/cmake/${PROJECT_NAME})

install(EXPORT ${PROJECT_NAME}Targets DESTINATION
  lib/cmake/${PROJECT_NAME} NAMESPACE ${PROJECT_NAME}::)

# End installation part

export(EXPORT ${PROJECT_NAME}Targets NAMESPACE ${PROJECT_NAME}::)

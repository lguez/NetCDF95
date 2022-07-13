cmake_minimum_required(VERSION 3.16)
list(APPEND CMAKE_MESSAGE_CONTEXT NetCDF95)
project(NetCDF95 LANGUAGES Fortran C)
enable_testing()
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS Debug Release Profile)
add_library(netcdf95 nf95_abort.f90 netcdf95.f90 nf95_def_dim.f90
  nf95_inq_dimid.f90 nf95_inquire_dimension.f90 nf95_constants.f90
  nc_constants.f90)
add_subdirectory(Attributes)
add_subdirectory(Datasets)
add_subdirectory(Groups)
add_subdirectory(Variables)
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

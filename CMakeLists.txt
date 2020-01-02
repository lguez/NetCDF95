cmake_minimum_required(VERSION 3.13)
project(NetCDF95 Fortran)
file(STRINGS file_list file_list_var)
add_library(netcdf95 ${file_list_var})
set_target_properties(netcdf95 PROPERTIES Fortran_FORMAT FREE)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})
include(ConfigureCompilerFlags)

find_path(netcdff_INCLUDE_DIR netcdf.mod)

target_include_directories(netcdf95 PRIVATE ${netcdff_INCLUDE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR})

target_sources(netcdf95 PRIVATE inq_numgrps.c nf95_inq_grp_full_ncid.f90
  nf95_inq_grpname.f90 nf95_inq_grpname_full.f90 nf95_inq_grps.f90
  nf95_inq_file_ncid.f90 nf95_inq_grp_parent.f90 nc_inq_grpname_len.f90)

# test_c_char
add_executable(test_c_char test_c_char.f90)
add_test(NAME default_c_char COMMAND test_c_char)

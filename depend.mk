check_start_count.o : nf95_inquire_variable.o nf95_close.o 
nf95_find_coord.o : nf95_inquire_variable.o nf95_inquire.o nf95_inquire_dimension.o nf95_inq_varid.o nf95_get_att.o 
nc_constants.o : 
nc_inq_grpname_len.o : 
netcdf95.o : nf95_create_single.o nf95_sync.o nf95_redef.o nf95_put_var.o nf95_put_att.o nf95_open.o nf95_inquire_variable.o nf95_inquire.o nf95_inquire_dimension.o nf95_inquire_attribute.o nf95_inq_varid.o nf95_inq_grps.o nf95_inq_grp_parent.o nf95_inq_grpname_full.o nf95_inq_grpname.o nf95_inq_grp_full_ncid.o nf95_inq_file_ncid.o nf95_inq_dimid.o nf95_gw_var.o nf95_get_var.o nf95_get_missing.o nf95_get_att.o nf95_enddef.o nf95_def_var.o nf95_def_dim.o nf95_create.o nf95_copy_att.o nf95_constants.o nf95_close.o nf95_abort.o nf95_find_coord.o 
nf95_abort.o : nf95_inq_file_ncid.o nf95_close.o 
nf95_close.o : nf95_constants.o 
nf95_copy_att.o : nf95_constants.o nf95_abort.o 
nf95_constants.o : nc_constants.o 
nf95_create.o : nf95_constants.o nf95_abort.o 
nf95_create_single.o : nf95_put_att.o nf95_def_var.o nf95_def_dim.o nf95_create.o 
nf95_def_dim.o : nf95_constants.o nf95_abort.o 
nf95_def_var.o : nf95_constants.o nf95_abort.o 
nf95_enddef.o : nf95_constants.o nf95_abort.o 
nf95_get_att.o : nf95_constants.o nf95_inquire_attribute.o nf95_abort.o 
nf95_get_missing.o : nf95_get_att.o 
nf95_get_var.o : nf95_get_var_array.h nf95_get_var_scalar.h nf95_constants.o nf95_get_missing.o check_start_count.o nf95_abort.o 
nf95_gw_var.o : nf95_inquire_dimension.o nf95_inquire_variable.o nf95_get_var.o 
nf95_inq_dimid.o : nf95_constants.o nf95_abort.o 
nf95_inq_file_ncid.o : nf95_inq_grp_parent.o nf95_constants.o 
nf95_inq_grp_full_ncid.o : nf95_constants.o nf95_abort.o nc_constants.o 
nf95_inq_grpname.o : nf95_abort.o nc_inq_grpname_len.o nc_constants.o 
nf95_inq_grpname_full.o : nf95_constants.o nf95_abort.o nc_inq_grpname_len.o nc_constants.o 
nf95_inq_grp_parent.o : nf95_constants.o nc_constants.o 
nf95_inq_grps.o : nf95_abort.o nc_constants.o 
nf95_inquire_attribute.o : nf95_constants.o nf95_abort.o 
nf95_inquire_dimension.o : nf95_constants.o nf95_abort.o 
nf95_inquire.o : nf95_constants.o nf95_abort.o 
nf95_inquire_variable.o : nf95_constants.o nf95_abort.o 
nf95_inq_varid.o : nf95_constants.o nf95_abort.o 
nf95_open.o : nf95_constants.o nf95_abort.o 
nf95_put_att.o : nf95_constants.o nf95_abort.o 
nf95_put_var.o : nf95_constants.o check_start_count.o nf95_abort.o 
nf95_redef.o : nf95_constants.o nf95_abort.o 
nf95_sync.o : nf95_constants.o nf95_abort.o 

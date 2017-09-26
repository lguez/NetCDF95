  call check_start_count(procedure_name, ncid, varid, start, count_nc, &
       rank_values)

  ncerr_not_opt = nf90_get_var(ncid, varid, values, start, count_nc, stride, &
       map)
  if (present(ncerr)) then
     ncerr = ncerr_not_opt
  else
     call handle_err(procedure_name, ncerr_not_opt, ncid, varid)
  end if

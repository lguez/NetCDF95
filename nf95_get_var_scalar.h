  call check_start_count(procedure_name, ncid, varid, start, rank_values=0)

  ncerr_not_opt = nf90_get_var(ncid, varid, values, start)
  if (present(ncerr)) then
     ncerr = ncerr_not_opt
  else
     call handle_err(procedure_name, ncerr_not_opt, ncid, varid)
  end if

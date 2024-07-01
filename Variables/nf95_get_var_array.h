  ! -*- mode: f90; -*-
  
  ! Body of specific procedures of generic interface "nf95_get_var",
  ! with array argument "values".
  
  call check_start_count(procedure_name, ncid, varid, start, count_nc, &
       rank_values)
  ncerr_not_opt = nf90_get_var(ncid, varid, values, start, count_nc, stride, &
       map)

  if (present(ncerr)) then
     ncerr = ncerr_not_opt
  else
     if (ncerr_not_opt /= nf95_noerr) call nf95_abort(procedure_name, &
          ncerr_not_opt, ncid, varid)
  end if

  if (ncerr_not_opt == NF95_NOERR .and. present(new_missing)) then
     call nf95_get_missing(ncid, varid, missing)
     where (values == missing) values = new_missing
  end if

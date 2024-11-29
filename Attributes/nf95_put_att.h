  ! -*- mode: f90; -*-
  
  ! Body of specific procedures of generic interface "nf95_put_att".
  
  ncerr_not_opt = nf90_put_att(ncid, varid, name, values)

  if (present(ncerr)) then
     ncerr = ncerr_not_opt
  else if (ncerr_not_opt /= nf95_noerr) then
     write(error_unit, fmt = *) "name = ", name
     write(error_unit, fmt = *) "values = ", values
     call nf95_abort(procedure_name, ncerr_not_opt, ncid, varid)
  end if

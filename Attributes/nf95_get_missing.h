  ! -*- mode: f90; -*-
  
  ! Body of specific procedures of generic interface "nf95_get_missing".
  
  call nf95_get_att(ncid, varid, name = "missing_value", values = missing_1, &
       ncerr = ncerr_1)
  call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
       ncerr = ncerr_2)

  if (ncerr_1 == nf95_noerr) then
     if (ncerr_2 == nf95_noerr) then
        if (missing_1 /= missing) then
           write(error_unit, fmt = *) "missing_value:", missing_1
           write(error_unit, fmt = *) "_FillValue:", missing
           call nf95_abort("nf95_get_missing: missing_value /= _FillValue", &
                ncid = ncid, varid = varid)
        end if
     else
        missing = missing_1
     end if
  else
     if (ncerr_2 /= nf95_noerr) missing = NF95_FILL_TYPE
  end if

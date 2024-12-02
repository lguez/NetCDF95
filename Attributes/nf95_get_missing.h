  ! -*- mode: f90; -*-
  
  ! Body of specific procedures of generic interface "nf95_get_missing".
  
  call nf95_get_att(ncid, varid, name = "missing_value", values = missing, &
       ncerr = ncerr)

  if (ncerr /= nf95_noerr) then
     call nf95_get_att(ncid, varid, name = "_FillValue", values = missing, &
          ncerr = ncerr)
     if (ncerr /= nf95_noerr) missing = NF95_FILL_TYPE
  end if

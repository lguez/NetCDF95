  ! -*- mode: f90; -*-
  
  ! Body of specific procedures of generic interface "nf95_get_missing".
  
  call nf95_inquire_attribute(ncid, varid, name = "missing_value", &
       xtype = xtype, ncerr = ncerr_1)

  if (ncerr_1 == nf95_noerr) then
     call nf95_get_att(ncid, varid, name = "missing_value", values = missing_1)

     if (xtype /= nf95_type) then
        write(error_unit, fmt = *) "Warning: nf95_get_missing: type mismatch"
        write(error_unit, fmt = *) "type of `missing` argument: ", nf95_type
        write(error_unit, fmt = *) "type of NetCDF attribute missing_value: ", &
             xtype
        write(error_unit, fmt = *) "Converted missing_value:", missing_1
        write(error_unit, fmt = *) "varid = ", varid
        write(error_unit, fmt = *) "End of warning"
     end if
  end if

  call nf95_inquire_attribute(ncid, varid, name = "_FillValue", xtype = xtype, &
       ncerr = ncerr_2)

  if (ncerr_2 == nf95_noerr) then
     call nf95_get_att(ncid, varid, name = "_FillValue", values = missing)

     if (xtype /= nf95_type) then
        write(error_unit, fmt = *) "Warning: nf95_get_missing: type mismatch"
        write(error_unit, fmt = *) "type of `missing` argument: ", nf95_type
        write(error_unit, fmt = *) "type of NetCDF attribute _FillValue: ", &
             xtype
        write(error_unit, fmt = *) "Converted _FillValue:", missing
        write(error_unit, fmt = *) "varid = ", varid
        write(error_unit, fmt = *) "End of warning"
     end if
  end if

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

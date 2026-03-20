# Changelog

## 0.15 (2026-03-20)

### Added

- Check the type external type when calling `nf95_get_att` with an
  argument `values` of type character (afd3432f)
- Manage string external type when calling `nf95_get_att` (0bae01e0)
- Write more information in case of error in `nf95_get_var` (ec031f72)
- Install find module for NetCDF-Fortran (7d53a2c4)
- Specify version in `CMakeLists.txt` (b5e88f8c)
- Add procedure `nf95_create_snc`
- Allow other values of units for longitude and latitude in
  `nf95_find_coord` (e39b8e16)
- Overload `nf95_get_var` with `nf95_get_var_4D_FourByteInt`
- Overload `nf95_gunp_var` with `nf95_gunp_var_real_4d`

### Changed

- Increase the minimum version of cmake to `3.21` (0ac437eb)
- Exclude multi-configuration generator
- Trim `full_name` in `nf95_inq_grp_full_ncid` (7d7eab8f)

## 0.14 (2025-06-25)

### Added

- Add argument ncerr to `nf95_find_coord`
- Create function `nf95_strerror`

### Fixed

- Make onebyteint private (78477be3)
- Do not crash if ncerr is present in call to `nf95_get_att_text`
- Write error message to stderr in `nf95_get_att_text`

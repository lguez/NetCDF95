# Changelog

## 0.14 ()

### Added

- Add argument ncerr to `nf95_find_coord`
- Create function `nf95_strerror`

### Fixed

- Make onebyteint private (78477be3)
- Do not crash if ncerr is present in call to `nf95_get_att_text`
- Write error message to stderr in `nf95_get_att_text`

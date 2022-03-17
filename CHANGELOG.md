# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.17.0]

### Added

- os
  - OS tags (BL64_OS_*)
  - AlmaLinux compatibility
- arc
  - AlmaLinux compatibility
- iam
  - AlmaLinux compatibility
- os
  - AlmaLinux compatibility
- pkg
  - AlmaLinux compatibility
- rxtx
  - AlmaLinux compatibility
- sudo
  - AlmaLinux compatibility
- vcs
  - AlmaLinux compatibility

### Changed

- arc
  - use BL64_OS_* for OS id
- iam
  - use BL64_OS_* for OS id
- os
  - use BL64_OS_* for OS id
- pkg
  - use BL64_OS_* for OS id
- rxtx
  - use BL64_OS_* for OS id
- sudo
  - use BL64_OS_* for OS id
- vcs
  - use BL64_OS_* for OS id

## [1.16.0]

### Added

- xsv
  - new module
- rxtx
  - new module
- core
  - BL64_LIB_DEBUG_CMD debug mode
  - command set for: vcs, sudo, rxtx
- vcs
  - bl64_vcs_git_clone: command check
  - bl64_vcs_set_command: new function
  - bl64_vcs_git_sparse: new function
- sudo
  - bl64_sudo_set_command: new function
- os
  - bl64_os_set_alias: awk, cp dir
  - bl64_os_set_command: gawk
  - bl64_os_cp_dir: new function
- check
  - bl64_check_command: optional error message
  - bl64_check_file: optional error message
  - bl64_check_directory: optional error message
- fmt
  - bl64_fmt_strip_starting_slash: new function
  - bl64_fmt_strip_ending_slash: new function
- os
  - bl64_os_set_command: gawk
  - bl64_os_set_alias: awk alias using gawk in traditional mode

### Changed

- fmt
  - bl64_fmt_dirname: accept both full and relative paths
  - bl64_fmt_basename: accept both full and relative paths

### Fixed

- rnd
  - bl64_rnd_get_alphanumeric: fixed max pool idx

## [1.15.0]

### Added

- iam
  - alias for useradd

[Unreleased]: https://github.com/serdigital64/bashlib64/compare/1.17.0...HEAD
[1.17.0]: https://github.com/serdigital64/bashlib64/compare/1.16.0...1.17.0
[1.16.0]: https://github.com/serdigital64/bashlib64/compare/1.15.0...1.16.0
[1.15.0]: https://github.com/serdigital64/bashlib64/releases/tag/1.15.0

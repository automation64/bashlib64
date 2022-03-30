# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.20.0]

### Added

- os
  - uname, true, false commands
  - MacOS support
- sudo
  - MacOS support
- vcs
  - MacOS support
- arc
  - MacOS support
- rxtx
  - MacOS support
- iam
  - MacOS support
- pkg
  - MacOS support
  - Aliases and commands setter

### Fixed

- os
  - Prevent shell exit when OS is not supported

## [1.19.0]

### Added

- dbg
  - new module
- core
  - verbose flag (BL64_LIB_VERBOSE)
  - move debug flags to module dbg
- xsv
  - bl64_xsv_dump: new function
  - use dbg flags
- msg
  - verbose flag

### Changed

- core
  - Renamed module to lib
- msg
  - Optimize batch message

## [1.18.0]

### Added

- core
  - shtop defaults
- check
  - bl64_check_parameter: check for placeholder (BL64_LIB_VAR_TBD)
- os
  - bl64_os_merge_dir: new function
  - bl64_os_match: new function
- iam
  - bl64_iam_set_command: new function
- rxtx
  - bl64_rxtx_set_alias: new function
- vcs
  - bl64_vcs_set_alias: new function
  - bl64_vcs_git_sparse: support for git with no sparse-checkout command

### Changed

- rxtx
  - bl64_rxtx_web_get_file: use aliases instead of commands
- os
  - bl64_os_set_alias: prefer mawk over gawk for ALIAS_AWK
  - bl64_os_get_distro: normalize exit status, normalize Debian version (10->10.0)
- vcs
  - bl64_vcs_git_sparse: use aliases instead of commands
  - bl64_vcs_git_clone: use aliases instead of commands

## [1.17.0]

### Added

- os
  - OS tags (BL64_OS_*)
  - AlmaLinux compatibility
  - RedHatLinux compatibility
- arc
  - AlmaLinux compatibility
  - RedHatLinux compatibility
- iam
  - AlmaLinux compatibility
  - RedHatLinux compatibility
- os
  - AlmaLinux compatibility
  - RedHatLinux compatibility
- pkg
  - AlmaLinux compatibility
  - RedHatLinux compatibility
- rxtx
  - AlmaLinux compatibility
  - RedHatLinux compatibility
- sudo
  - AlmaLinux compatibility
  - RedHatLinux compatibility
- vcs
  - AlmaLinux compatibility
  - RedHatLinux compatibility

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

[Unreleased]: https://github.com/serdigital64/bashlib64/compare/1.20.0...HEAD
[1.20.0]: https://github.com/serdigital64/bashlib64/compare/1.19.0...1.20.0
[1.19.0]: https://github.com/serdigital64/bashlib64/compare/1.18.0...1.19.0
[1.18.0]: https://github.com/serdigital64/bashlib64/compare/1.17.0...1.18.0
[1.17.0]: https://github.com/serdigital64/bashlib64/compare/1.16.0...1.17.0
[1.16.0]: https://github.com/serdigital64/bashlib64/compare/1.15.0...1.16.0
[1.15.0]: https://github.com/serdigital64/bashlib64/releases/tag/1.15.0

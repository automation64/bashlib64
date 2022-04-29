# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0]

### Added

- lib
  - Reset bash set options to default
  - Enable error tracing bash set options
  - Signal traps for ERR,DEBUG,EXIT
- dbg
  - bl64_dbg_callstack_show
  - bl64_dbg_lib_show_function
  - bl64_dbg_app_show_function

### Changed

- all
  - Optimized code to use new bashlib64 functions

## [1.26.0]

### Added

- rxtx
  - bl64_rxtx_set_options: added options
  - bl64_rxtx_web_get_file: added option to set file permissions

### Fixed

- rxtx:
  - Fixed wrong variable name
- arc,rbac,vcs
  - Fixed status var declaration type

## [1.25.0]

### Added

- core:
  - debugging of EXIT trap
- dbg:
  - bl64_dbg_runtime_show: new function
- chk:
  - added function caller info

## [1.24.0]

### Added

- fs: bl64_fs_create_dir skip actions if path is already present

## [1.23.0]

### Added

- check
  - bl64_check_path_absolute: new function
  - bl64_check_privilege_not_root: new function
  - bl64_check_privilege_root: new function
  - bl64_check_overwrite: new function
  - bl64_check_command: detect unsupported command
- py
  - New module
- fs
  - New module
- sudo
  - bl64_sudo_run_command: new function
- dbg
  - bl64_dbg_app_show_vars: new function
  - bl64_dbg_lib_show_vars: new function
- os
  - OS command flags aliases
- msg
  - bl64_msg_show_unsupported: new function

### Changed

- all
  - Declare numeric constants as integers
  - Renamed constant BL64_LIB_VAR_TBD to BL64_LIB_DEFAULT
- os
  - Migrated fs related functions to module fs
- sudo
  - Module renamed to rbac
- fmt
  - bl64_fmt_basename: return error when unable to determine basename

## [1.22.0]

### Added

- check:
  - bl64_check_path_relative: new function
- pkg
  - Brew update
- rxtx
  - bl64_rxtx_git_get_dir: allow full repo copy (source path: .)

### Fixed

- os
  - bl64_os_merge_dir: fixed typo

## [1.21.0]

### Added

- lib
  - Bash version check
- os
  - Fedora34, Debian9, OracleLinux7, Centos7, Centos9 support
- pkg
  - Fedora34, Debian9, OracleLinux7, Centos7, Centos9 support
- rxtx
  - Fedora34, Debian9, OracleLinux7, Centos7, Centos9 support
- vcs
  - Fedora34, Debian9, OracleLinux7, Centos7, Centos9 support

### Fixed

- os
  - fixed false,true paths on DEB-_|UB-_

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
  - aliases and commands setter

### Fixed

- os
  - Prevent shell exit when OS is not supported

## [1.19.0]

### Added

- dbg
  - New module
- core
  - verbose flag (BL64_LIB_VERBOSE)
- xsv
  - bl64_xsv_dump: new function
  - Use dbg flags
- msg
  - verbose flag

### Changed

- core
  - Moved debug flags to module dbg
  - Renamed module to lib
- msg
  - Optimize batch message

## [1.18.0]

### Added

- core
  - shtop defaults
- check
  - bl64_check_parameter: added check for placeholder (BL64_LIB_VAR_TBD)
- os
  - bl64_os_merge_dir: new function
  - bl64_os_match: new function
- iam
  - bl64_iam_set_command: new function
- rxtx
  - bl64_rxtx_set_alias: new function
- vcs
  - bl64_vcs_set_alias: new function
  - bl64_vcs_git_sparse: added support for git with no sparse-checkout command

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
  - OS tags (`BL64*OS*`)
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

- Use `BL64*OS*` for OS id

## [1.16.0]

### Added

- xsv
  - New module
- rxtx
  - New module
- core
  - BL64_LIB_DEBUG_CMD debug mode
  - command set for: vcs, sudo, rxtx
- vcs
  - bl64_vcs_git_clone: added command check
  - bl64_vcs_set_command: new function
  - bl64_vcs_git_sparse: new function
- sudo
  - bl64_sudo_set_command: new function
- os
  - bl64_os_set_alias: added awk, cp dir
  - bl64_os_set_command: added gawk
  - bl64_os_cp_dir: new function
- check
  - bl64_check_command: added optional error message
  - bl64_check_file: added optional error message
  - bl64_check_directory: added optional error message
- fmt
  - bl64_fmt_strip_starting_slash: new function
  - bl64_fmt_strip_ending_slash: new function
- os
  - bl64_os_set_command: added gawk
  - bl64_os_set_alias: added awk alias using gawk in traditional mode

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

[unreleased]: https://github.com/serdigital64/bashlib64/compare/1.24.0...HEAD
[1.24.0]: https://github.com/serdigital64/bashlib64/compare/1.23.0...1.24.0
[1.23.0]: https://github.com/serdigital64/bashlib64/compare/1.22.0...1.23.0
[1.22.0]: https://github.com/serdigital64/bashlib64/compare/1.21.0...1.22.0
[1.21.0]: https://github.com/serdigital64/bashlib64/compare/1.20.0...1.21.0
[1.20.0]: https://github.com/serdigital64/bashlib64/compare/1.19.0...1.20.0
[1.19.0]: https://github.com/serdigital64/bashlib64/compare/1.18.0...1.19.0
[1.18.0]: https://github.com/serdigital64/bashlib64/compare/1.17.0...1.18.0
[1.17.0]: https://github.com/serdigital64/bashlib64/compare/1.16.0...1.17.0
[1.16.0]: https://github.com/serdigital64/bashlib64/compare/1.15.0...1.16.0
[1.15.0]: https://github.com/serdigital64/bashlib64/releases/tag/1.15.0

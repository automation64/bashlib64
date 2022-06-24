# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [3.3.0]

### Added

- bsh
  - new module

## [3.2.0]

### Added

- fs
  - new function: bl64_fs_set_ephemeral
- py
  - new function: bl64_py_venv_check
  - register requested venv
  - support ephemeral paths
- ans
  - python venv support

### Changed

- ans
  - bl64_py_setup: use base path instead of binary for parameter-1

- gcp
  - bl64_gcp_setup: use base path instead of binary for parameter-1

## [3.1.0]

### Changed

- py
  - merged bl64_py_venv_activate into bl64_py_setup

### Fixed

- py
  - pip install: do not use --user when VENV is in use

## [3.0.0]

### Added

- fs
  - new functions: bl64_fs_run_cp, bl64_fs_run_ls, bl64_fs_run_ln, bl64_fs_set_umask

### Changed

- fs:
  - **Breaking change** Normalizeed wrapper functions names:
    - bl64_fs_chown -> bl64_fs_run_chown
    - bl64_fs_chmod -> bl64_fs_run_chmod
    - bl64_fs_mkdir -> bl64_fs_run_mkdir
    - bl64_fs_mv -> bl64_fs_run_mv

### Removed

- fs
  - **Breaking change** removed obsolete functions:
    - bl64_fs_ls_files

## [2.14.0]

### Added

- check
  - new function: bl64_check_path_not_present
- py
  - all: virtual environments support with venv
  - new function: bl64_py_venv_activate, bl64_py_venv_create

## [2.13.0]

### Added

- Fedora 36 support

## [2.12.0]

### Added

- all
  - added setup module function
- core
  - added shell wide defaults for umask
- os
  - new function: bl64_os_get_uid
- rbac
  - new function: bl64_rbac_run_bash_function
- fs
  - new function: bl64_fs_set_permissions
- iam
  - new functions: bl64_iam_user_is_created, bl64_iam_user_get_id, bl64_iam_user_get_current
- check
  - new function: bl64_check_user

### Changed

- os
  - **Breaking change** normalized function locations
    - bl64_os_get_uid -> bl64_iam_user_get_id

### Removed

- dbg
  - removed obsolete function: bl64_dbg_runtime_get_script_path

## [2.11.0]

- dbg:
  - add debug all flag
- pkg
  - add module setup
  - add apk,yum,dnf,brew,apt wrappers
- py
  - normalize environment: reset PYTHON* shell environment variables to defaults

## [2.10.0]

### Added

- fs
  - bl64_fs_merge_files: added rollback

## [2.9.0]

### Added

- fs
  - bl64_fs_merge_files: overwrite option
- ans
  - bl64_ans_setup: set ansible path
- cnt
  - new function: cnt_run

## [2.8.0]

### Added

- check
  - new function: bl64_check_path

### Changed

- fs:
  - promoted from internal to public: bl64_fs_restore, bl64_fs_safeguard

## [2.7.0]

### Added

- ans:
  - new module
- gcp
  - new function: bl64_gcp_setup
- py
  - new function: bl64_py_setup
- cnt
  - new function: bl64_cnt_setup

### Changed

- gcp
  - module is now optional
- py
  - module is now optional
- cnt
  - module is now optional
- check
  - renamed bl64_check_show_* to bl64_check_alert_*

## [2.6.0]

### Added

- all: add Rocky Linux 8, Ubuntu 22.4 support

## [2.5.0]

### Added

- arc
  - new functions: bl64_arc_run_tar, bl64_arc_open_zip
- msg
  - new functions: bl64_msg_show_lib_task, bl64_msg_verbose_app_enabled, bl64_msg_verbose_lib_enabled
  - library level verbose option
- cnt
  - new function: bl64_cnt_run_sh, bl64_cnt_tag

## [2.4.0]

### Added

- py
  - bl64_py_run_python: new function
- gcp
  - new module

### Changed

- py
  - Use bl64_py_run_python instead of CMD_PYTHON3
- os
  - migrated awp,grep,gawk to module txt

## [2.3.0]

### Added

- arc:
  - bl64_arc_run_tar: new function
- rxtx:
  - bl64_rxtx_run_curl: new function
  - bl64_rxtx_run_wget: new function

### Changed

- os
  - Update gawk detection
- rxtx
  - Update wget detection
  - Use bl64_rxtx_run_* wrappers
- arc
  - Use bl64_arc_run_tar
- py:
  - Renamed: bl64_py_pip_run -> bl64_py_run_pip

## [2.2.0]

### Added

- cnt
  - bl64_cnt_login: new function
  - bl64_cnt_build: new function
  - bl64_cnt_push: new function
  - bl64_cnt_pull: new function
- dbg
  - bl64_dbg_runtime_get_script_path: new function

## [2.0.0]

### Added

- lib
  - Reset bash set options to default
  - Enable error tracing bash set options
  - Signal traps for ERR,DEBUG,EXIT
- dbg
  - bl64_dbg_runtime_show_callstack: new function
  - bl64_dbg_lib_show_function: new function
  - bl64_dbg_app_show_function: new function
- fs
  - bl64_fs_find_files: new function
- os
  - bl64_os_awk: new function
- fmt
  - bl64_fmt_list_to_string: new function
  - bl64_fmt_separator_line: new function
- check
  - bl64_check_show_undefined: new function
- cnt
  - new module

### Changed

- all
  - Optimized code to use new bashlib64 functions
  - **Breaking change** Centralized error codes
- os
  - **Breaking change** Migrated fs related functions to the fs module
  - **Breaking change** Migrated archive related functions to the arc module
- msg
  - **Breaking change** moved bl64_msg_show_unsupported to check module

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

[unreleased]: https://github.com/serdigital64/bashlib64/compare/3.3.0...HEAD
[3.3.0]: https://github.com/serdigital64/bashlib64/compare/3.2.0...3.3.0
[3.2.0]: https://github.com/serdigital64/bashlib64/compare/3.1.0...3.2.0
[3.1.0]: https://github.com/serdigital64/bashlib64/compare/3.0.0...3.1.0
[3.0.0]: https://github.com/serdigital64/bashlib64/compare/2.14.0...3.0.0
[2.14.0]: https://github.com/serdigital64/bashlib64/compare/2.13.0...2.14.0
[2.13.0]: https://github.com/serdigital64/bashlib64/compare/2.12.0...2.13.0
[2.12.0]: https://github.com/serdigital64/bashlib64/compare/2.11.0...2.12.0
[2.11.0]: https://github.com/serdigital64/bashlib64/compare/2.10.0...2.11.0
[2.10.0]: https://github.com/serdigital64/bashlib64/compare/2.9.0...2.10.0
[2.9.0]: https://github.com/serdigital64/bashlib64/compare/2.8.0...2.9.0
[2.8.0]: https://github.com/serdigital64/bashlib64/compare/2.7.0...2.8.0
[2.7.0]: https://github.com/serdigital64/bashlib64/compare/2.6.0...2.7.0
[2.6.0]: https://github.com/serdigital64/bashlib64/compare/2.5.0...2.6.0
[2.5.0]: https://github.com/serdigital64/bashlib64/compare/2.4.0...2.5.0
[2.4.0]: https://github.com/serdigital64/bashlib64/compare/2.3.0...2.4.0
[2.3.0]: https://github.com/serdigital64/bashlib64/compare/2.2.0...2.3.0
[2.2.0]: https://github.com/serdigital64/bashlib64/compare/2.0.0...2.2.0
[2.0.0]: https://github.com/serdigital64/bashlib64/compare/1.24.0...2.0.0
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

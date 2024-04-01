# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [19.4.1]

### Added

- iam
  - bl64_iam_run_*: wrappers for user add commands 
  - bl64_iam_group_add: add local user group
  - bl64_iam_group_is_created: verify that group exists
  - bl64_iam_user_add: added UID parameter (optional)
  - bl64_iam_xdg_create: create user's xdg dirs
  - bl64_iam_user_modify: modify existing user attributes
- os
  - bl64_os_run_getent: getent wrapper
- fs
  bl64_fs_create_file: create empty file

### Fixed

- pkg
  - bl64_pkg_upgrade: removed '--' param separator to avoid incorrect interpretation by package manager (e.g.: alpine apk)

## [19.3.0]

### Added

- bsh
  - bl64_bsh_command_is_executable, bl64_bsh_command_get_path

## [19.2.1]

### Added

- all
  - OS flavor support: to allow compatibility functions to check against OS families instead of particular distros.
  - AmazonLinux 2023 support

### Changed

- os
  - bl64_os_match: renamed to `bl64_os_is_distro`. Old name kept for compatibility until version 21
  - bl64_os_match_compatible: renamed to `bl64_os_is_compatible`. Old name kept for compatibility until version 21

### Fixed

- core
  - Added missing Debian-12 compatibility check

## [19.1.0]

### Added

- all
  - Added Debian12 support
- cnt
  - bl64_cnt_check_in_container,bl64_cnt_check_not_in_container: new check functions
- os
  - bl64_os_run_sleep: new wrapper function

### Changed

- core
  - Add to the auto-setup task remaining optional modules that do not require init parameters
- py
  - Optimized command detection
  - Droped obsolete globals: `BL64_PY_CMD_PYTHON3*`

### Fixed

- rxtx
  - Fixed module setup
- msg
  - bl64_msg_show_batch_finish: fixed wrong exit status when verbose=NONE

## [19.0.0]

### Added

- cryp
  - new module for cryptography tools: GPG, OpenSSL

### Changed

- all
  - global variables are now declared by default instead of exported to enhance script re-entry (fork)
- py
  - bl64_py_venv_check: improved check method
- rxtx
  - bl64_rxtx_web_get_file: added param for setting owner, group
- pkg
  - **Breaking change**: added module dependency: `cryp`
  - bl64_pkg_repository_add: added GPG key dearmor for Ubuntu

## [18.1.1]

### Added

- os
  - bl64_os_match_compatible: compares current OS against the target list and matches if the OS is compatible
  - bl64_os_check_compatibility: checks that current OS is compatible against a target list

### Changed

- core
  - restored initial library compatibility check but using bl64_os_check_compatibility() to allow execution when then there is no exact OS match

## [18.0.0]

### Fixed

- all
  - removed dependency to allow individual module loading
- cnt
  - bl64_cnt_is_inside_container: fixed testing of shell-env when var is not defined

### Changed

- check
  - **Breaking change**: bl64_check_module_imported: migrated to core module: bl64_lib_module_imported

### Added

- core
  - bl64_lib_module_imported: migrated from check (bl64_lib_module_imported)
- bsh
  - bl64_bsh_env_import_yaml: import and load shell environment variables from YAML file
- check
  - bl64_check_command: 3rd parameter to show command name when not available

### Refact

- check
  - bl64_check_export,bl64_check_parameter,bl64_check_module: replaced eval with test -n

## [17.3.0]

### Added

- xsv
  - bl64_xsv_run_yq, bl64_xsv_run_jq: runners for YQ and JQ

### Changed

- all
  - updated module dependency check
  - improved debugging and error messages format
  - trivial modules (msg,log,check) excluded from debugging messages
- core
  - removed dbg and bsh module dependencies from main section
- bsh
  - migrated bl64 specific functions to core module. Functions will map to the new ones until removed in next major release
    - bl64_bsh_script_set_id() -> bl64_lib_script_set_id
    - bl64_bsh_script_set_identity -> bl64_lib_script_set_identity

## [17.2.0]

### Changed

- arc
  - bl64_arc_run_tar,bl64_arc_run_zip: increased verbosity
- rxtx
  - bl64_rxtx_run_curl,bl64_rxtx_web_get_file,bl64_rxtx_git_get_dir: increased verbosity

### Fixed

- fs
  - bl64_fs_create_symlink: typo in override variable

## [17.1.0]

### Added

- k8s
  - bl64_k8s_run_kubectl_plugin: wrapper for calling kubectl plugins
- dbg
  - bl64_dbg_lib_show_variables,bl64_dbg_app_show_variables: show shell variable and attributes
- all
  - add fedora 39 support
  - add ubuntu 23.10 support

### Changed

- k8s
  - bl64_k8s_run_kubectl: allow using default kubeconf
- check
  - bl64_check_parameters_none: allow using optional error message

## [17.0.0]

### Added

- os
  - support for unknown OS version when compatibility mode is set
- py
  - support for unknown OS version when compatibility mode is set

### Changed

- pkg
  - update OS version compatibility list
- hlm
  - bl64_hlm_chart_upgrade: create namespace if missing

## [16.1.0]

### Added

- os
  - tee command definition
- fmt
  - bl64_fmt_check_value_in_list: check parameter value is part of list
- fs
  - bl64_fs_check_new_file,bl64_fs_check_new_dir: check new file or dir path is valid
  - bl64_fs_create_symlink: ln -s wrapper

### Fixed

- fs
  - bl64_fs_merge_files: check that the target is valid
- rxtx
  - bl64_rxtx_git_get_dir,bl64_rxtx_web_get_file: check that the target is valid, fail when API call fails
  - bl64_rxtx_github_get_asset: fail when API call fails
- api
  - bl64_api_call: fail when API call fails

## [16.0.0]

### Added

- pkg
  - bl64_pkg_repository_add: debian support
- dbg
  - bl64_dbg_app_show_comments,bl64_dbg_lib_show_comments: show developer comments during debugging sessions
- core
  - added support to allow for individual module sourcing in addition to all-in-one bashlib64 file
- iam
  - bl64_iam_check_user: migrated from bl64_check_user
- check
  - bl64_lib_module_imported: check that the bl64 module is imported (sourced)

### Changed

- pkg
  - bl64_pkg_repository_add: make gpgkey optional
- msg
  - **Breaking change** bl64_msg_show_batch_finish: return provided exit status instead of always true. This is to enable using the function as last command in the script
- check
  - **Breaking change** migrated bl64_check_user to bl64_iam_check_user
  - **Breaking change** renamed: bl64_check_compatibility -> bl64_check_compatibility_mode

### Fixed

- iam
  - bl64_iam_user_add: force creation of primary group in SLES distros
- core
  - **Breaking change** normalize VAR values:
    - BL64_VAR_NONE='_NONE_'
    - BL64_VAR_ALL='_ALL_'
- pkg
  - **Breaking change** bl64_pkg_install: add flag to not install recommended packages on debian

## [15.0.0]

### Added

- iam
  - bl64_iam_user_add: added shell, primary group,geco options
- msg
  - bl64_msg_show_separator
- core
  - bl64_lib_flag_is_enabled: query external flag type variables. Flag value can be string (YES|ON|NO|OFF) or var BL64_VAR_ON|BL64_VAR_OFF

### Changed

- iam
  - MacOS: replaced dscl for sysadminctl

[19.4.1]: https://github.com/automation64/bashlib64/compare/19.3.0...19.4.1
[19.3.0]: https://github.com/automation64/bashlib64/compare/19.2.1...19.3.0
[19.2.1]: https://github.com/automation64/bashlib64/compare/19.1.0...19.2.1
[19.1.0]: https://github.com/automation64/bashlib64/compare/19.0.0...19.1.0
[19.0.0]: https://github.com/automation64/bashlib64/compare/18.1.1...19.0.0
[18.1.1]: https://github.com/automation64/bashlib64/compare/18.0.0...18.1.1
[18.0.0]: https://github.com/automation64/bashlib64/compare/17.3.0...18.0.0
[17.3.0]: https://github.com/automation64/bashlib64/compare/17.2.0...17.3.0
[17.2.0]: https://github.com/automation64/bashlib64/compare/17.1.0...17.2.0
[17.1.0]: https://github.com/automation64/bashlib64/compare/17.0.0...17.1.0
[17.0.0]: https://github.com/automation64/bashlib64/compare/16.1.0...17.0.0
[16.1.0]: https://github.com/automation64/bashlib64/compare/16.0.0...16.1.0
[16.0.0]: https://github.com/automation64/bashlib64/compare/15.0.0...16.0.0
[15.0.0]: https://github.com/automation64/bashlib64/compare/14.0.0...15.0.0

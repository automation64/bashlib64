# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [10.1.0]

### Added

- os
  - new function: bl64_os_check_version
- fs
  - new wrapper: bl64_fs_run_rm
- cnt
  - module setup: added options and paths

### Fixed

- tf
  - module setup

## [10.0.2]

### Added

- os
  - new function: bl64_os_lang_is_available, bl64_os_set_lang
- txt
  - new function: bl64_txt_run_egrep
- check,fmt,rnd
  - added module setup

### Changed

- os
  - **Breaking change**: now using C.UTF-8 instead of C as default locale where supported. Setting can still be overwired or completely ignored as needed
- dbg
  - normalize debugging values when using -D in scripts
- all
  - renamed internal functions to use the prefix `_`

### Fixed

- cnt
  - bl64_cnt_is_inside_container: replaced local-n bash for eval for compatibility
- check
  - bl64_check_export: add missing parameter check

## [9.2.4]

### Fixed

- txt
  - bl64_txt_run_awk: removed extra quotes that can cause null run
- rbac
  - bl64_rbac_add_root: now create new sudoers when there is no previous one

### Added

- hlm
  - new function: bl64_hlm_set_timeout
- cnd
  - new function: bl64_cnt_is_inside_container

### Changed

- os
  - bl64_os_match: **Breaking change** removed support for plain OS alias. Use predefined variables BL64_OS_XXX. For example: "$BL64_OS_<ALIAS>" "${BL64_OS_<ALIAS>}-V" "${BL64_OS_<ALIAS>}-V.S"
- k8s
  - bl64_k8s_set_version: optimized to allow support for different cli versions

## [9.1.4]

### Fixed

- py
  - bl64_py_set_command: added OS subversion check for Python version to Alpine
- pkg
  - bl64_pkg_run_apt: restrict verbose mode to install,remove,upgrade in apt-get
- rback
  - bl64_rbac_add_root: fixed backup check when original sudoers is empty
- cnt
  - add missing module load check

### Added

- fs
  - new functions: bl64_fs_chmod_dir, bl64_fs_fix_permissions
- rbac
  - new set options for sudo

### Changed

- txt
  - bl64_txt_run_awk, bl64_txt_set_command: migrated AWK detection to setup and created global BL64_TXT_CMD_AWK_POSIX

## [9.0.1]

### Fixed

- fs
  - bl64_fs_cleanup_full: removed bl64_pkg_cleanup as is out of scope for the function purpose

### Changed

- lib
  - env: **Breaking change**: renamed constants
    - `BL64_LIB_VAR_* -> BL64_VAR_*`
    - `BL64_LIB_DEFAULT -> BL64_VAR_DEFAULT`
    - `BL64_LIB_INCOMPATIBLE -> BL64_VAR_INCOMPATIBLE`
    - `BL64_LIB_UNAVAILABLE -> BL64_VAR_UNAVAILABLE`
    - `BL64_LIB_NULL -> BL64_VAR_NULL`
- cnt
  - bl64_cnt_build*: now accepts free form args (@)
- os
  - removed unused export: BL64_OS_TAGS
  - bl64_os_match: allow usage of BL64_OS_XXX variables for OS match
- fs
  - bl64_fs_set_permissions: **Breaking change**: moved `path` parameter to 4th position and converted to list to allow multiple paths

### Fixed

- os
  - _bl64_os_get_distro_from_os_release: normalized Alpine OS version to match X.Y

## [8.1.1]

### Added

- aws: set region for aws_run
- msg: added subtask, phase

## [8.0.0]

### Changed

- core:
  - **Breaking change**: removed auto-setup of: arc, pkg
- check
  - **Breaking change**: refactored bl64_check_module_setup -> bl64_check_module, parameter is not the module name
- k8s
  - bl64_k8s_namespace_create: does nothing if ns is already there

### Added

- core
  - added generation of `bashlib64-core` and `bashlib64-opt` libraries to reduce footprint
- lib:
  - in addition to the full bashlib64 library there are now two smaller ones: bashlib64-core (base library with core modules only) and bashlib64-opt (optional modules)
- ui: new user interface module
  - bl64_ui_ask_confirmation()
- py
  - new functions: bl64_py_pip_usr_cleanup, bl64_py_pip_usr_deploy
- dbg
  - new functions: bl64_dbg_lib_command_trace_start, bl64_dbg_lib_command_trace_stop, bl64_check_alert_module_setup
- check
  - new function: bl64_check_alert_module_setup
- msg
  - new function: bl64_msg_show_lib_info
- k8s
  - new function: bl64_k8s_resource_is_created, bl64_k8s_set_version, bl64_k8s_sa_create, bl64_k8s_annotation_set, bl64_k8s_secret_create, bl64_k8s_resource_get

### Fixed

- chk
  - bl64_check_status: fix wrong parameter type

## [7.1.0]

### Added

- all
  - OracleLinux9 support
  - RedHat9 support
- ans
  - setting for ansible_config
- dbg
  - allow custom debug level for app usage

## [7.0.0]

### Added

- pkg
  - add package repository (YUM)

- fs
  - touch cmd

### Changed

- log
  - refactored to integrate with msg module
- msg
  - integrated with log module to record messages

### Removed

- log
  - bl64_log_record
- check
  - bl64_check_alert_failed

[10.1.0]: https://github.com/serdigital64/bashlib64/compare/10.0.1...10.1.0
[10.0.2]: https://github.com/serdigital64/bashlib64/compare/10.0.2...9.2.4
[9.2.4]: https://github.com/serdigital64/bashlib64/compare/9.2.4...9.1.4
[9.1.4]: https://github.com/serdigital64/bashlib64/compare/9.1.4...9.0.1
[9.0.1]: https://github.com/serdigital64/bashlib64/compare/8.1.1...9.0.1
[8.1.1]: https://github.com/serdigital64/bashlib64/compare/8.0.0...8.1.1
[8.0.0]: https://github.com/serdigital64/bashlib64/compare/7.1.0...8.0.0
[7.1.0]: https://github.com/serdigital64/bashlib64/compare/7.0.0...7.1.0
[7.0.0]: https://github.com/serdigital64/bashlib64/compare/6.0.0...7.0.0

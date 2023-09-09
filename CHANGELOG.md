# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

## [14.0.0]

### Added

- core
  - generic compatibility mode flag to allow using untested versions
  - flag query functions
- k8s
  - support for k8s api 1.28
  - generic compatibility mode for supporting untested versions
- check
  - bl64_check_compatibility: helper for checking compatibility mode
  - bl64_check_overwrite_skip: helper for checking overwrite condition
- rxtx
  - bl64_rxtx_github_get_asset: use special tag latest to obtain latest version

### Changed

- cnt
  - **Breaking change** docker_build: removed --rm and --no-cache flags to let caller choose. Set docker progress to plain
  - **Breaking change** docker_run: removed --rm flag to let caller choose

### Fixed

- os
  - bl64_os_match: refactored to evaluate major and minor as numbers instead of strings to avoid left-zero issue (20.04 != 20.4)

## [13.0.0]

### Added

- api
  - new module for interacting with RESTful APIs
  - functions: bl64_api_url_encode, bl64_api_call

### Changed

- fmt
  - **Breaking change** moved bl64_fmt_strip_comments to bl64_txt_strip_comments
- txt
  - added bl64_txt_strip_comments (moved from fmt module)
- vcs
  - bl64_vcs_github_run_api: added $@ for extra params, redirect curl option. Refactored to use bl64_api_call

## [12.6.0]

### Added

- check
  - added check command in search path
- fs
  - added global path for temporal files
  - new function: bl64_fs_run_mktemp, bl64_fs_create_tmpdir, bl64_fs_create_tmpfile, bl64_fs_rm_tmpfile, bl64_fs_rm_tmpdir

### Fixed

- vcs
  - bl64_vcs_github_run_api: fixed parameter quoting

## [12.5.0]

### Added

- core
  - make shell forget paths (hash)
  - protect builtins using builtin keyword

### Fixed

- rxtx
  - fix curl opts for debian11

## [12.4.0]

### Added

- all
  - add fedora 38

## [12.3.0]

### Added

- all
  - added version info
  - added ubuntu 18.4 support
- k8s
  - added kubectl 1.27 support
- gcp
  - added CLI settings: project, impersonate sa
  - added get GCP Secret value
- vcs
  - added github api call, get latest release
- rxtx
  - added github asset download

## [12.2.1]

### Added

- all
  - added ubuntu 23.04 support
- tf
  - added set version. Available on BL64_TF_VERSION

### Changed

- tf
  - bl64_tf_log_set: log file is now optional. Default set to STDERR
- bsh
  - normalized internal set version function
- k8s
  - normalized internal set version function
- ans
  - normalized internal set version function

## [12.1.0]

### Added

- msg: bl64_msg_show_lib_task

### Fixed

- msg:
  - bl64_msg_set_output: default theme setting
- fs:
  - bl64_fs_merge_files: wrong stdout redirection placement

## [12.0.0]

### Added

- all
  - sles-15 support
- check
  - new function: bl64_check_alert_resource_not_found

### Changed

- msg:
  - **Breaking change** Normalized theme ID value. Now use one of BL64_MSG_THEME_ID_ASCII_STD, BL64_MSG_THEME_ID_ANSI_STD

### Fixed

- ans
  - setup: path definition when using custom location

## [11.0.0]

### Added

- all
  - added rockylinux9, almalinux9, fedora37, mcos13 support

## [10.3.0]

### Added

- txt
  - new functions: bl64_txt_run_uniq, bl64_txt_run_sort
- cnt
  - new functions: bl64_cnt_login_stdin,bl64_cnt_container_is_running

## [10.2.2]

### Added

- cnt
  - new functions: bl64_cnt_cli,bl64_cnt_network_is_defined,bl64_cnt_network_create
- k8s
  - added 1.26 API support

### Changed

- msg
  - bl64_check_alert_unsupported: allow extra error details
- cnt
  - normalized internal function names to avoid external use (bl64_cnt_docker_*, bl64_cnt_podman_*)
  - added task process msg

### Fixed

- msg
  - added missing lib info style

## [10.1.1]

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

[15.0.0]: https://github.com/automation64/bashlib64/compare/14.0.0...15.0.0
[14.0.0]: https://github.com/automation64/bashlib64/compare/13.0.0...14.0.0
[13.0.0]: https://github.com/automation64/bashlib64/compare/12.6.0...13.0.0
[12.6.0]: https://github.com/automation64/bashlib64/compare/12.5.0...12.6.0
[12.5.0]: https://github.com/automation64/bashlib64/compare/12.4.0...12.5.0
[12.4.0]: https://github.com/automation64/bashlib64/compare/12.3.0...12.4.0
[12.3.0]: https://github.com/automation64/bashlib64/compare/12.2.1...12.3.0
[12.2.1]: https://github.com/automation64/bashlib64/compare/12.1.0...12.2.1
[12.1.0]: https://github.com/automation64/bashlib64/compare/12.0.0...12.1.0
[12.0.0]: https://github.com/automation64/bashlib64/compare/11.0.0...12.0.0
[11.0.0]: https://github.com/automation64/bashlib64/compare/10.3.0...11.0.0
[10.3.0]: https://github.com/automation64/bashlib64/compare/10.2.2...10.3.0
[10.2.2]: https://github.com/automation64/bashlib64/compare/10.1.1...10.2.2
[10.1.1]: https://github.com/automation64/bashlib64/compare/10.0.1...10.1.1
[10.0.2]: https://github.com/automation64/bashlib64/compare/10.0.2...9.2.4

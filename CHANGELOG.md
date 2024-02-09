# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [19.1.0]

### Added

- os
  - bl64_os_run_sleep: added function

### Changed

- py
  - Optimized command detection

### Fixed

- rxtx
  - Fixed module setup

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

## [14.0.0]

### Added

- core
  - generic compatibility mode flag to allow using untested versions
  - flag query functions
- k8s
  - support for k8s api 1.28
  - generic compatibility mode for supporting untested versions
- check
  - bl64_check_compatibility_mode: helper for checking compatibility mode
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

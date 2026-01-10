# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [22.12.0]

### Added

- arc
  - bl64_arc_gzip_open
  - bl64_arc_bzip2_open
  - bl64_arc_7z_open
- msg
  - bl64_msg_app_run_is_enabled
  - bl64_msg_app_detail_is_enabled
- os
  - bl64_os_raise_platform_unsupported

### Fixed

- arc
  - bl64_arc_run_bunzip2: typo, missing hardener
  - missing harden functions
- msg
  - Verbosity type: detailed (BL64_MSG_VERBOSE_DETAIL)

### Deprecated

- msg
  - Verbosity type: BL64_MSG_VERBOSE_LIB. Replaced by BL64_MSG_VERBOSE_DETAIL
  - bl64_msg_lib_enable_verbose
  - bl64_msg_lib_verbose_is_enabled
- arc
  - bl64_arc_open_tar: renamed to bl64_arc_tar_open
  - bl64_arc_open_zip: renamed to bl64_arc_zip_open

## [22.11.0]

### Added

- arc
  - bl64_arc_run_zip: command wrapper
  - bl64_arc_run_7zz: command wrapper
- core
  - bl64_lib_mode_cicd_is_enabled: query CICD mode
- cryp
  - bl64_cryp_run_md5sum: command wrapper
  - bl64_cryp_run_sha256sum: command wrapper
- vcs
  - bl64_vcs_github_run_api: use GITHUB_TOKEN if present and no token was requested

### Changed

- msg
  - Force ASCII output when CICD mode is enabled

### Fixed

- dbg
  - bl64_dbg_*_show_vars: show UNDEF when var is not defined

## [22.10.0]

### Added

- msg
  - New theme: emoji

## [22.9.0]

### Added

- msg
  - New formats: TIME2, SCRIPT2, FULL2

### Changed

- msg
  - bl64_msg_set_output: allow full output name (ANSI, ASCII)

### Fixed

- core
  - get script name

## [22.8.1]

### Added

- all
  - Manjaro Linux support
  - SLES 16 Linux support
- msg
  - Message format: SCRIPT, SCRIPT2

### Fixed

- pkg
  - removed invalid parameter for Debian flavor verbose

## [22.7.0]

### Added

- all
  - CachyOS Linux support

## [22.6.4]

### Added

- all
  - ArchLinux support, OEL10, Debian13, Fedora43 support

### Deprecated

- cnt
  - BL64_CNT_PATH_DOCKER_SOCKET
  - bl64_cnt_set_paths

## [22.5.2]

### Added

- core
  - bl64_lib_script_minver_check
- tf
  - OpenTofu support
- xsv
  - PKL-Lang support
- fmt
  - bl64_fmt_version_is_less_than_or_equal
  - bl64_fmt_version_is_less_than
  - bl64_fmt_version_check_semver_format
- bsh
  - bl64_bsh_command_import

### Changed

- bsh
  - bl64_bsh_command_locate: added /usr/local/sbin. Do not fail if command is not found
- k8s, mdb, ans, gcp, hlm
  - Command detection now uses bl64_bsh_command_import. Requires BSH module

### Fixed

- hlm
  - bl64_hlm_chart_upgrade: kubeconfig check
- check
  - bl64_check_export: missing null value check
- msg
  - bl64_msg_show_setup: non existing vars

## [22.4.1]

### Added

- bsh
  - bl64_bsh_command_locate_user

## [22.3.1]

### Changed

- msg
  - bl64_msg_show_setup: skip empty vars
  - BL64_MSG_FORMAT_*: values are now human readable

### Fixed

- fs
  - bl64_fs_path_merge: use cp dereference to avoid link copy issues

## [22.2.0]

### Added

- fs
  - bl64_fs_path_merge: option for disabling recursive copy
- bsh:
  - bl64_bsh_pattern_match_file

### Changed

- fs
  - bl64_fs_file_remove: accept empty file list
  - bl64_fs_path_copy: accept empty file list, create destination
  - bl64_fs_file_copy: accept empty file list
  - bl64_fs_dir_create: now create parents if not present

### Fixed

- iam
  - bl64_iam_user_modify: parameter order
- fs
  - bl64_fs_symlink_create: existing symlink detection
  - bl64_fs_file_remove: existing symlink detection

### Deprecated

- fs
  - bl64_fs_find_files -> bl64_fs_file_search
  - bl64_fs_chown_dir -> bl64_fs_run_chown
  - bl64_fs_chmod_dir -> bl64_fs_run_chmod
  - bl64_fs_mkdir_full -> bl64_fs_run_mkdir
  - bl64_fs_merge_files -> bl64_fs_file_merge
  - bl64_fs_merge_dir -> bl64_fs_path_merge

## [22.1.1]

### Added

- all
  - RockyLinux 10 support
- pkg
  - HomeBrew support for Linux
  - bl64_pkg_run_softwareupdate
  - bl64_pkg_run_installer
- msg
  - bl64_msg_show_app_error
- arc
  - bl64_arc_run_gunzip

### Fixed

- iam
  - bl64_iam_setup: added missing module dependency: FMT
- pkg
  - bl64_pkg_repository_add: fixed parameter check

## [22.0.0]

### Added

- all
  - AlmaLinux 10 support
  - CentOS 10 support
  - RHEL 10 support
  - Ubuntu 25 support
- bsh
  - bl64_bsh_job_try
- ui
  - bl64_ui_ask_proceed
- pkg
  - bl64_pkg_run_rpm
  - bl64_pkg_run_dpkg
- txt
  - bl64_txt_run_fmt
- msg
  - bl64_msg_show_check
  - bl64_msg_show_lib_error

### Changed

- api
  - bl64_api_setup: **breaking-change**: added BSH dependency for retry command
  - bl64_api_call: added retry on error
- pkg
  - *_run_*: removed root check, moved to specific commands that need it
- ui
  - bl64_ui_ask_confirmation: removed retry routine
- os
  - bl64_os_is_compatible: removed compatibility warning

## [21.2.0]

### Added

- all
  - Fedora 42 support

## [21.1.3]

### Deprecated

- ui
  - bl64_ui_confirmation_ask -> bl64_ui_ask_confirmation

### Added

- fs
  - bl64_fs_path_move
- ui
  - bl64_ui_ask_input_date
  - bl64_ui_ask_input_time
  - bl64_ui_ask_input_semver
  - bl64_ui_ask_input_string
  - bl64_ui_ask_input_decimal
  - bl64_ui_ask_input_integer
  - bl64_ui_ask_input_free
  - bl64_ui_ask_yesno

### Fixed

- py
  - pip version dependent options
- msg
  - bl64_msg_show_lib_subtask: do not show in app verbose mode

## [21.0.0]

### Added

- os
  - bl64_os_check_flavor
- arc
  - bl64_arc_run_unxz
  - bl64_arc_run_bunzip2

### Changed

- all
  - **breaking-change**: demoted `*_blank_*` functions to private
- py
  - bl64_py_run_pip, bl64_py_run_pipx: disable progress display if CICD is on
  - bl64_py_run_pip, bl64_py_run_pipx: add security harden
- vcs
  - bl64_vcs_git_clone, bl64_vcs_run_git: disable progress display if CICD is on
- pkg
  - bl64_pkg_run_brew: ensure key vars are set

## [20.18.2]

### Added

- txt
  - bl64_txt_run_tail

### Changed

- fs
  - bl64_fs_symlink_create: now emulates Linux symlink permissions on MacOS

## [20.17.0]

### Changed

- arc
  - bl64_arc_run_unzip, bl64_arc_run_tar: disable progress display if CICD is on
- aws
  - bl64_aws_run_aws: disable progress display if CICD is on
- rxtx
  - bl64_rxtx_run_curl: disable progress display if CICD is on

### Fixed

- txt
  - bl64_txt_line_replace_sed: typo

## [20.16.2]

### Changed

- os
  - **breaking-change**: renamed BL64_OS_TYPE_DARWIN -> BL64_OS_TYPE_MACOS

### Added

- bsh
  - XDG paths variables
  - bl64_bsh_xdg_create
- py:
  - BL64_PY_PATH_PIP_USR_BIN
  - Autodetect python version

### Deprecated

- iam
  - bl64_iam_xdg_create -> bl64_bsh_xdg_create

## [20.15.1]

### Added

- core
  - BL64_LIB_CICD: flag to indicate non-interactive mode (e.g. CICD pipeline, etc.). Default: OFF
- py
  - KaliLinux 2025 support

### Fixed

- cnt
  - missing check when no CLI is available

### Changed

- bl64_msg_set_output: now accepts default value for output. Default will be ASCII for non-interactive mode, and ANSI for interactive

## [20.14.0]

### Changed

- txt
  - Module now depends on module-fs
  - bl64_txt_search_line: now uses grep -Fx instead of regexp

### Added

- cnt
  - Added rancher desktop support
- iam
  - _bl64_iam_set_command: system group and user definition
- txt
  - bl64_txt_line_replace_sed: supports stdin and file

## [20.13.0]

### Added

- os
  - _bl64_os_set_machine: normalized machine types
- core
  - Check bash compatibility at bootstrap
- txt
  - bl64_txt_line_replace_sed
- msg
  - bl64_msg_show_fatal

## [20.12.3]

### Fixed

- arc
  - bl64_arc_open_tar: wrong param for MCOS
- os
  - _bl64_os_get_distro_from_uname: add missing version normalizer

### Added

- fmt
  - bl64_fmt_version_convert_to_major_minor
- os
  - bl64_os_run_uname
  - BL64_OS_TYPE
  - BL64_OS_MACHINE

### Deprecated

- fmt
  - bl64_fmt_strip_starting_slash -> 'bl64_fmt_path_strip_starting_slash'
  - bl64_fmt_strip_ending_slash -> 'bl64_fmt_path_strip_ending_slash'
  - bl64_fmt_basename ->' 'bl64_fmt_path_get_basename'
  - bl64_fmt_dirname ->' 'bl64_fmt_path_get_dirname'
  - bl64_fmt_list_to_string ->' 'bl64_fmt_list_convert_to_string'
  - bl64_fmt_separator_line ->' 'bl64_ui_separator_show'
  - bl64_fmt_check_value_in_list -> 'bl64_fmt_list_check_membership'
- ui
  - bl64_ui_ask_confirmation -> bl64_ui_confirmation_ask

## [20.11.0]

### Added

- fmt
  - bl64_fmt_version_is_major_minor
  - bl64_fmt_version_is_major
  - bl64_fmt_version_is_semver

### Changed

- msg
  - bl64_msg_show_batch_start: default msg is now BL64_SCRIPT_ID
  - bl64_msg_show_batch_stop: default msg is now BL64_SCRIPT_ID

### Fixed

- core
  - Missing OS in compatibility list

## [20.10.0]

### Added

- py
  - bl64_py_run_pipx
- os
  - bl64_os_check_not_version

### Changed

- core
  - Added missing std shell vars handling to bootstrap
- py
  - Added missing python versions
  - Added new python version

## [20.9.1]

### Changed

- fs
  - bl64_fs_file_remove: now removes links and files only, fails if not correct file type

## [20.8.0]

### Added

- msg
  - bl64_msg_help_show: new help function
  - bl64_msg_show_about: show about msg

### Fixed

- txt
  - bl64_txt_setup: wrong debugging func name

### Deprecated

- msg
  - bl64_msg_show_usage: replaced by bl64_msg_help_show

## [20.7.0]

### Added

- core
  - SCRIPT_VERSION to register caller version
  - bl64_lib_script_version_set: setter for SCRIPT_VERSION
- os
  - bl64_os_run_date
  - bl64_os_run_cat
- fs
  - bl64_fs_run_touch
  - bl64_fs_file_copy
  - bl64_fs_file_backup
  - bl64_fs_file_restore
- log
  - bl64_log_set_target: added supports for multiple target type
- dbg
  - bl64_dbg_app_dryrun_show
  - bl64_dbg_lib_dryrun_show 
  - bl64_dbg_app_dryrun_is_enabled
  - bl64_dbg_lib_dryrun_is_enabled
  - bl64_dbg_all_dryrun_disable
  - bl64_dbg_all_dryrun_enable
  - bl64_dbg_app_dryrun_enable
  - bl64_dbg_lib_dryrun_enable

### Removed

- core
  - bl64_lib_alert_parameter_invalid: migrated to msg internal function
  - bl64_lib_module_is_setup: migrated to msg internal function
  - bl64_lib_module_imported: demoted to internal function

### Fixed

- tm
  - added missing OS module dependency
- rbac
  - bl64_rbac_add_root: fixed wrong deprecation replacement

### Deprecated

- msg
  - bl64_msg_app_verbose_enabled: replaced by bl64_msg_app_verbose_is_enabled
  - bl64_msg_lib_verbose_enabled: replaced by bl64_msg_app_detail_is_enabled
- fs
  - bl64_fs_create_file: replaced by bl64_fs_file_create
  - bl64_fs_create_symlink: replaced by bl64_fs_symlink_create
  - bl64_fs_safeguard: replaced by bl64_fs_path_archive
  - bl64_fs_restore: replaced by bl64_fs_path_recover
- log
  - bl64_log_set_runtime: replaced by bl64_log_set_target
- dbg
  - bl64_dbg_app_task_enabled: replaced by bl64_dbg_app_task_is_enabled
  - bl64_dbg_lib_task_enabled: replaced by bl64_dbg_lib_task_is_enabled
  - bl64_dbg_app_command_enabled: replaced by 4_dbg_app_command_is_enabled
  - bl64_dbg_lib_command_enabled: replaced by 4_dbg_lib_command_is_enabled
  - bl64_dbg_app_trace_enabled: replaced by l64_dbg_app_trace_is_enabled
  - bl64_dbg_lib_trace_enabled: replaced by l64_dbg_lib_trace_is_enabled
  - bl64_dbg_app_custom_1_enabled: replaced by _dbg_app_custom_1_is_enabled
  - bl64_dbg_app_custom_2_enabled: replaced by _dbg_app_custom_2_is_enabled
  - bl64_dbg_app_custom_3_enabled: replaced by _dbg_app_custom_3_is_enabled
  - bl64_dbg_lib_check_enabled: replaced by l64_dbg_lib_check_is_enabled
  - bl64_dbg_lib_log_enabled: replaced by  _bl64_dbg_lib_log_is_enabled
  - bl64_dbg_lib_msg_enabled: replaced by  _bl64_dbg_lib_msg_is_enabled

### Changed

- fs
  - bl64_fs_file_create: no longer shows warning if file already exists

## [20.6.1]

### Added

- all
  - Fedora 41 support

### Fixed

- vcs
  - bl64_vcs_changelog_get_release: failure to detect found section end

## [20.5.0]

### Added

- bsh
  - bl64_bsh_profile_path_generate: NPM search path

## [20.4.0]

### Added

- msg
  - bl64_msg_show_deprecated
  - bl64_msg_show_setup
- bsh
  - bl64_bsh_command_locate

### Changed

- xsv
  - now dependes on bsh module

## [20.3.0]

### Added

- all
  - Kali Linux support

### Changed

- core
  - Changed BL64_VAR_DEFAULT value to facilitate usage from CLI: `_` -> `DEFAULT`
  - bl64_lib_var_is_default: accept both new and legacy values

### Fixed

- os
  - bl64_os_is_flavor: fixed param check

### Deprecated

- lib
  - bl64_dbg_app_show_variables: replaced by bl64_dbg_app_show_globals
  - bl64_dbg_lib_show_variables: replaced by bl64_dbg_lib_show_globals

## [20.2.1]

### Added

- bsh
  - bl64_bsh_run_pushd
  - bl64_bsh_run_popd
- fs
  - bl64_fs_dir_reset
  - bl64_fs_file_remove
  - bl64_fs_dir_create
  - bl64_fs_dir_reset

### Fixed

- crypt
  - bl64_cryp_gpg_key_armor: error condition when source is already armored

### Changed

- pkg
  - Use `apt` instead of `apt-get`

### Deprecated

- bl64_fs_create_dir: migrate to bl64_fs_dir_create
- bl64_fs_ln_symbolic: migrate to bl64_fs_create_symlink

## [20.1.3]

### Added

- msg
  - bl64_msg_show_init: message for script initialization
- fs
  - bl64_fs_path_copy
  - bl64_fs_path_permission_set
  - bl64_fs_path_remove
- aws
  - bl64_aws_set_home: allow using custom AWS_HOME
- vcs
  - bl64_vcs_changelog_get_release: get release description

### Modified

- aws
  - bl64_aws_setup: allow using custom AWS_HOME

### Deprecated

- fs
  - bl64_fs_copy_files: migrate to bl64_fs_path_copy
  - bl64_fs_cp_file: migrate to bl64_fs_path_copy
  - bl64_fs_cp_dir: migrate to bl64_fs_path_copy
  - bl64_fs_set_permissions: migrate to bl64_fs_path_permission_set
  - bl64_fs_fix_permissions: migrate to bl64_fs_path_permission_set
  - bl64_fs_rm_file: migrate to bl64_fs_path_remove
  - bl64_fs_rm_full: migrate to bl64_fs_path_remove

## [20.0.0]

### Added

- aws
  - bl64_aws_set_access_*: Set CLI access modes: SSO, Profile, IAM Key, Session Token

### Changed

- aws
  - **Breaking change**: updated functions to use new access mode
    - bl64_aws_sso_login
    - bl64_aws_sts_get_caller_arn

### Removed

- aws
  - **Breaking change**: bl64_aws_run_aws_profile: use bl64_aws_run_aws instead with bl64_aws_set_access_*

## [19.6.0]

### Changed

- vcs
  - bl64_vcs_git_clone: added optional new repo name

## [19.5.5]

### Added

- all
  - Fedora 40 support
  - Ubuntu 24.4 support
- bsh
  - env store support
  - bash profile snippet generators
  - PATH snippet generator
- k8s
  - cli compatibility for 1.3x

### Fixed

- iam
  - bl64_iam_user_add: SLES: do not force primary group creation when group name is provided
  - bl64_iam_xdg_create: add missing default dir permission

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
  - **Breaking change**: bl64_check_module_imported: migrated to core module: _bl64_lib_module_is_imported

### Added

- core
  - _bl64_lib_module_is_imported: migrated from check (_bl64_lib_module_is_imported)
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
  - _bl64_lib_module_is_imported: check that the bl64 module is imported (sourced)

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

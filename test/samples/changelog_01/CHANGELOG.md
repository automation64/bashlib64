# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [20.1.0]

### Added

- msg
  - bl64_msg_show_init: message for script initialization
- fs
  - bl64_fs_path_copy
  - bl64_fs_path_permission_set
  - bl64_fs_path_remove
- aws
  - bl64_aws_set_home: allow using custom AWS_HOME

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

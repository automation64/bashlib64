#######################################
# BashLib64 / Module / Functions / Manage native OS packages
#######################################

#######################################
# Add package repository
#
# * Covers simple uses cases that can be applied to most OS versions:
#   * YUM: repo package definition created
#   * APT: repo package definition created, GPGkey downloaded and installed
# * Package cache is not refreshed
# * No replacement done if already present
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   $1: repository name. Format: alphanumeric, _-
#   $2: repository source. Format: URL
#   $3: GPGKey source. Format: URL. Default: $BL64_VAR_NONE
#   $4: extra package specific parameter. For APT: suite. Default: empty
#   $5: extra package specific parameter. For APT: component. Default: empty
#
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   package manager exit status
#######################################
function bl64_pkg_repository_add() {
  bl64_dbg_lib_show_function "$@"
  local name="${1:-}"
  local source="${2:-}"
  local gpgkey="${3:-${BL64_VAR_NONE}}"
  local extra1="${4:-}"
  local extra2="${5:-}"

  bl64_check_privilege_root &&
    bl64_check_parameter 'name' ||
    bl64_check_parameter 'source' ||
    return $?

  bl64_msg_show_lib_subtask "$_BL64_PKG_TXT_REPOSITORY_ADD (${name})"
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    _bl64_pkg_repository_add_apt "$name" "$source" "$gpgkey" "$extra1" "$extra2"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    _bl64_pkg_repository_add_yum "$name" "$source" "$gpgkey"
    ;;
  ${BL64_OS_SLES}-*)
    bl64_check_alert_unsupported
    ;;
  ${BL64_OS_ALP}-*)
    bl64_check_alert_unsupported
    ;;
  ${BL64_OS_MCOS}-*)
    bl64_check_alert_unsupported
    ;;
  *) bl64_check_alert_unsupported ;;

  esac
}

function _bl64_pkg_repository_add_yum() {
  bl64_dbg_lib_show_function "$@"
  local name="$1"
  local source="$2"
  local gpgkey="$3"
  local definition=''

  bl64_check_directory "$BL64_PKG_PATH_YUM_REPOS_D" ||
    return $?

  definition="${BL64_PKG_PATH_YUM_REPOS_D}/${name}.${BL64_PKG_DEF_SUFIX_YUM_REPOSITORY}"
  [[ -f "$definition" ]] &&
    bl64_msg_show_warning "${_BL64_PKG_TXT_REPOSITORY_EXISTING} (${definition})" &&
    return 0

  bl64_dbg_lib_show_info "create YUM repository definition (${definition})"
  if [[ "$gpgkey" != "$BL64_VAR_NONE" ]]; then
    printf '[%s]\n
name=%s
baseurl=%s
gpgcheck=1
enabled=1
gpgkey=%s\n' \
      "$name" \
      "$name" \
      "$source" \
      "$gpgkey" \
      >"$definition"
  else
    printf '[%s]\n
name=%s
baseurl=%s
gpgcheck=0
enabled=1\n' \
      "$name" \
      "$name" \
      "$source" \
      >"$definition"
  fi
}

function _bl64_pkg_repository_add_apt() {
  bl64_dbg_lib_show_function "$@"
  local name="$1"
  local source="$2"
  local gpgkey="$3"
  local extra1="$4"
  local extra2="$5"
  local definition=''
  local gpgkey_file=''
  local file_mode='0644'

  bl64_check_directory "$BL64_PKG_PATH_APT_SOURCES_LIST_D" &&
    bl64_check_directory "$BL64_PKG_PATH_GPG_KEYRINGS" ||
    return $?

  definition="${BL64_PKG_PATH_APT_SOURCES_LIST_D}/${name}.${BL64_PKG_DEF_SUFIX_APT_REPOSITORY}"
  [[ -f "$definition" ]] &&
    bl64_msg_show_warning "${_BL64_PKG_TXT_REPOSITORY_EXISTING} (${definition})" &&
    return 0

  bl64_dbg_lib_show_info "create APT repository definition (${definition})"
  if [[ "$gpgkey" != "$BL64_VAR_NONE" ]]; then
    gpgkey_file="${BL64_PKG_PATH_GPG_KEYRINGS}/${name}.${BL64_PKG_DEF_SUFIX_GPG_FILE}"
    printf 'deb [signed-by=%s] %s %s %s\n' \
      "$gpgkey_file" \
      "$source" \
      "$extra1" \
      "$extra2" \
      >"$definition" ||
      return $?
    bl64_dbg_lib_show_info "install GPG key (${gpgkey})"
    bl64_rxtx_web_get_file "$gpgkey" "$gpgkey_file" "$BL64_VAR_ON" "$file_mode"
  else
    printf 'deb %s %s %s\n' \
      "$source" \
      "$extra1" \
      "$extra2" \
      >"$definition"
  fi
}

#######################################
# Refresh package repository
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_repository_refresh() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_subtask "$_BL64_PKG_TXT_REPOSITORY_REFRESH"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_pkg_run_apt 'update'
    ;;
  ${BL64_OS_FD}-*)
    bl64_pkg_run_dnf 'makecache'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    bl64_pkg_run_dnf 'makecache'
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.* | ${BL64_OS_ALM}-9.* | ${BL64_OS_RCK}-9.*)
    bl64_pkg_run_dnf 'makecache'
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    bl64_pkg_run_yum 'makecache'
    ;;
  ${BL64_OS_SLES}-*)
    bl64_pkg_run_zypper 'refresh'
    ;;
  ${BL64_OS_ALP}-*)
    bl64_pkg_run_apk 'update'
    ;;
  ${BL64_OS_MCOS}-*)
    bl64_pkg_run_brew 'update'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Deploy packages
#
# * Before installation: prepares the package manager environment and cache
# * After installation: removes cache and temporary files
#
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: process output
#   STDERR: process stderr
# Returns:
#   n: process exist status
#######################################
function bl64_pkg_deploy() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none $# || return $?

  bl64_pkg_prepare &&
    bl64_pkg_install "$@" &&
    bl64_pkg_upgrade &&
    bl64_pkg_cleanup
}

#######################################
# Initialize the package manager for installations
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_prepare() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_subtask "$_BL64_PKG_TXT_PREPARE"
  bl64_pkg_repository_refresh
}

#######################################
# Install packages
#
# * Assume yes
# * Avoid installing docs (man) when possible
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_install() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none $# || return $?

  bl64_msg_show_lib_subtask "$_BL64_PKG_TXT_INSTALL (${*})"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_pkg_run_apt 'install' $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES -- "$@"
    ;;
  ${BL64_OS_FD}-*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.* | ${BL64_OS_ALM}-9.* | ${BL64_OS_RCK}-9.*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    bl64_pkg_run_yum $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
    ;;
  ${BL64_OS_SLES}-*)
    bl64_pkg_run_zypper 'install' $BL64_PKG_SET_ASSUME_YES -- "$@"
    ;;
  ${BL64_OS_ALP}-*)
    bl64_pkg_run_apk 'add' -- "$@"
    ;;
  ${BL64_OS_MCOS}-*)
    "$BL64_PKG_CMD_BRW" 'install' "$@"
    ;;
  *) bl64_check_alert_unsupported ;;

  esac
}

#######################################
# Upgrade packages
#
# * Assume yes
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
# shellcheck disable=SC2120
function bl64_pkg_upgrade() {
  bl64_dbg_lib_show_function "$@"

  bl64_msg_show_lib_subtask "$_BL64_PKG_TXT_UPGRADE"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_pkg_run_apt 'upgrade' $BL64_PKG_SET_ASSUME_YES -- "$@"
    ;;
  ${BL64_OS_FD}-*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' -- "$@"
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' -- "$@"
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.* | ${BL64_OS_ALM}-9.* | ${BL64_OS_RCK}-9.*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' -- "$@"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    bl64_pkg_run_yum $BL64_PKG_SET_ASSUME_YES 'upgrade' -- "$@"
    ;;
  ${BL64_OS_SLES}-*)
    bl64_pkg_run_zypper 'update' $BL64_PKG_SET_ASSUME_YES -- "$@"
    ;;
  ${BL64_OS_ALP}-*)
    bl64_pkg_run_apk 'upgrade' -- "$@"
    ;;
  ${BL64_OS_MCOS}-*)
    "$BL64_PKG_CMD_BRW" 'upgrade' "$@"
    ;;
  *) bl64_check_alert_unsupported ;;

  esac
}

#######################################
# Clean up the package manager run-time environment
#
# * Warning: removes cache contents
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_cleanup() {
  bl64_dbg_lib_show_function
  local target=''

  bl64_msg_show_lib_subtask "$_BL64_PKG_TXT_CLEAN"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_pkg_run_apt 'clean'
    ;;
  ${BL64_OS_FD}-*)
    bl64_pkg_run_dnf 'clean' 'all'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    BL64_PKG_CMD_DNF='/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.* | ${BL64_OS_ALM}-9.* | ${BL64_OS_RCK}-9.*)
    BL64_PKG_CMD_DNF='/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    bl64_pkg_run_yum 'clean' 'all'
    ;;
  ${BL64_OS_SLES}-*)
    bl64_pkg_run_zypper 'clean' '--all'
    ;;
  ${BL64_OS_ALP}-*)
    bl64_pkg_run_apk 'cache' 'clean'
    target='/var/cache/apk'
    if [[ -d "$target" ]]; then
      bl64_fs_rm_full ${target}/[[:alpha:]]*
    fi
    ;;
  ${BL64_OS_MCOS}-*)
    bl64_pkg_run_brew 'cleanup' --prune=all -s
    ;;
  *) bl64_check_alert_unsupported ;;

  esac
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_dnf() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root &&
    bl64_check_module 'BL64_PKG_MODULE' ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_DNF" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_yum() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root &&
    bl64_check_module 'BL64_PKG_MODULE' ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_YUM" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_apt() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root &&
    bl64_check_module 'BL64_PKG_MODULE' ||
    return $?

  bl64_pkg_blank_apt

  # Verbose is only available for a subset of commands
  if bl64_dbg_lib_command_enabled && [[ "$*" =~ (install|upgrade|remove) ]]; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    export DEBCONF_NOWARNINGS='yes'
    export DEBCONF_TERSE='yes'
    verbose="$BL64_PKG_SET_QUIET"
  fi

  # Avoid interactive questions
  export DEBIAN_FRONTEND="noninteractive"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_APT" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_pkg_blank_apt() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited DEB* shell variables'
  bl64_dbg_lib_trace_start
  unset DEBIAN_FRONTEND
  unset DEBCONF_TERSE
  unset DEBCONF_NOWARNINGS
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_apk() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root &&
    bl64_check_module 'BL64_PKG_MODULE' ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_APK" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_brew() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root &&
    bl64_check_module 'BL64_PKG_MODULE' ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_BRW" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_zypper() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root &&
    bl64_check_module 'BL64_PKG_MODULE' ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_ZYPPER" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

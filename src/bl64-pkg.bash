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
    bl64_check_parameter 'name' &&
    bl64_check_parameter 'source' ||
    return $?

  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      _bl64_pkg_repository_add_apt "$name" "$source" "$gpgkey" "$extra1" "$extra2"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
      _bl64_pkg_repository_add_yum "$name" "$source" "$gpgkey"
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
  local file_mode='0644'

  bl64_check_directory "$BL64_PKG_PATH_YUM_REPOS_D" ||
    return $?

  definition="${BL64_PKG_PATH_YUM_REPOS_D}/${name}.${BL64_PKG_DEF_SUFIX_YUM_REPOSITORY}"
  [[ -f "$definition" ]] &&
    bl64_msg_show_warning "requested repository is already present. Continue using existing one. (${definition})" &&
    return 0

  bl64_msg_show_lib_subtask "create YUM repository definition (${definition})"
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
  [[ -f "$definition" ]] && bl64_fs_run_chmod "$file_mode" "$definition"
}

function _bl64_pkg_repository_add_apt() {
  bl64_dbg_lib_show_function "$@"
  local name="$1"
  local source="$2"
  local gpgkey="$3"
  local suite="$4"
  local component="$5"
  local definition=''
  local gpgkey_file=''
  local file_mode='0644'

  bl64_check_parameter 'suite' &&
    bl64_check_directory "$BL64_PKG_PATH_APT_SOURCES_LIST_D" &&
    bl64_check_directory "$BL64_PKG_PATH_GPG_KEYRINGS" ||
    return $?

  definition="${BL64_PKG_PATH_APT_SOURCES_LIST_D}/${name}.${BL64_PKG_DEF_SUFIX_APT_REPOSITORY}"
  [[ -f "$definition" ]] &&
    bl64_msg_show_warning "requested repository is already present. Continue using existing one. (${definition})" &&
    return 0

  bl64_msg_show_lib_subtask "create APT repository definition (${definition})"
  if [[ "$gpgkey" != "$BL64_VAR_NONE" ]]; then
    gpgkey_file="${BL64_PKG_PATH_GPG_KEYRINGS}/${name}.${BL64_PKG_DEF_SUFIX_GPG_FILE}"
    printf 'deb [signed-by=%s] %s %s %s\n' \
      "$gpgkey_file" \
      "$source" \
      "$suite" \
      "$component" \
      >"$definition" &&
      bl64_cryp_key_download \
        "$gpgkey" "$gpgkey_file" "$BL64_VAR_DEFAULT" "$file_mode"
  else
    printf 'deb %s %s %s\n' \
      "$source" \
      "$suite" \
      "$component" \
      >"$definition"
  fi
  [[ -f "$definition" ]] && bl64_fs_run_chmod "$file_mode" "$definition"
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

  bl64_msg_show_lib_subtask 'refresh package repository content'
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apt 'update'
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf 'makecache'
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      bl64_check_privilege_root &&
        bl64_pkg_run_yum 'makecache'
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf 'makecache'
      ;;
    ${BL64_OS_SLES}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_zypper 'refresh'
      ;;
    ${BL64_OS_ALP}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apk 'update'
      ;;
    ${BL64_OS_ARC}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_pacman --sync --refresh
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_pkg_brew_repository_refresh
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

function bl64_pkg_brew_repository_refresh() {
  bl64_dbg_lib_show_function
  bl64_msg_show_lib_subtask 'refresh package repository content'
  bl64_pkg_run_brew 'update'
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
  bl64_pkg_prepare &&
    bl64_pkg_install "$@" &&
    bl64_pkg_upgrade "$@" &&
    bl64_pkg_cleanup
}

function bl64_pkg_brew_deploy() {
  bl64_dbg_lib_show_function "$@"
  bl64_pkg_brew_prepare &&
    bl64_pkg_brew_install "$@" &&
    bl64_pkg_brew_upgrade "$@" &&
    bl64_pkg_brew_cleanup
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

  bl64_msg_show_lib_subtask 'initialize package manager'
  bl64_pkg_repository_refresh
}

function bl64_pkg_brew_prepare() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_subtask 'initialize package manager'
  bl64_pkg_brew_repository_refresh
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

  bl64_msg_show_lib_subtask "install packages (${*})"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apt 'install' $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES -- "$@"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' "$@"
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      bl64_check_privilege_root &&
        bl64_pkg_run_yum $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' "$@"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_zypper 'install' $BL64_PKG_SET_ASSUME_YES -- "$@"
      ;;
    ${BL64_OS_ALP}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apk 'add' -- "$@"
      ;;
    ${BL64_OS_ARC}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_pacman --sync $BL64_PKG_SET_ASSUME_YES "$@"
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_pkg_brew_install "$@"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

function bl64_pkg_brew_install() {
  bl64_dbg_lib_show_function "$@"
  bl64_pkg_run_brew 'install' "$@"
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

  bl64_msg_show_lib_subtask "upgrade packages${*:+ (${*})}"

  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apt 'upgrade' $BL64_PKG_SET_ASSUME_YES "$@"
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' "$@"
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      bl64_check_privilege_root &&
        bl64_pkg_run_yum $BL64_PKG_SET_ASSUME_YES 'upgrade' "$@"
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' "$@"
      ;;
    ${BL64_OS_SLES}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_zypper 'update' $BL64_PKG_SET_ASSUME_YES "$@"
      ;;
    ${BL64_OS_ALP}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apk 'upgrade' "$@"
      ;;
    ${BL64_OS_ARC}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_pacman --sync $BL64_PKG_SET_ASSUME_YES "$@"
      ;;
    ${BL64_OS_MCOS}-*)
      bl64_pkg_brew_upgrade "$@"
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

function bl64_pkg_brew_upgrade() {
  bl64_dbg_lib_show_function "$@"
  bl64_pkg_run_brew 'upgrade' "$@"
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

  bl64_msg_show_lib_subtask 'clean up package manager run-time environment'
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_KL}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apt 'clean'
      ;;
    ${BL64_OS_FD}-* | ${BL64_OS_AMZ}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf 'clean' 'all'
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      bl64_check_privilege_root &&
        bl64_pkg_run_yum 'clean' 'all'
      ;;
    ${BL64_OS_CNT}-* | ${BL64_OS_OL}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_RCK}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_dnf 'clean' 'all'
      ;;
    ${BL64_OS_SLES}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_zypper 'clean' '--all'
      ;;
    ${BL64_OS_ALP}-*)
      bl64_check_privilege_root &&
        bl64_pkg_run_apk 'cache' 'clean'
      target='/var/cache/apk'
      if [[ -d "$target" ]]; then
        bl64_fs_path_remove ${target}/[[:alpha:]]*
      fi
      ;;
    ${BL64_OS_ARC}-*) : ;;
    ${BL64_OS_MCOS}-*)
      bl64_pkg_brew_cleanup
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

function bl64_pkg_brew_cleanup() {
  bl64_dbg_lib_show_function
  bl64_pkg_run_brew 'cleanup' \
    --prune=all \
    -s
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_dnf() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_PKG_SET_QUIET"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_yum() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_PKG_SET_QUIET"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_apt() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  _bl64_pkg_harden_apt

  # Verbose is only available for a subset of commands
  if bl64_msg_app_run_is_enabled && [[ "$*" =~ (install|upgrade|remove) ]]; then
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
function _bl64_pkg_harden_apt() {
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_apk() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_PKG_SET_QUIET"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_brew() {
  bl64_dbg_lib_show_function "$@"
  local verbose='--quiet'

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_command "$BL64_PKG_CMD_BREW" &&
    bl64_check_parameters_none "$#" &&
    bl64_check_privilege_not_root ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose='--verbose'

  export HOMEBREW_PREFIX="$BL64_PKG_PATH_BREW_HOME"
  export HOMEBREW_CELLAR="${BL64_PKG_PATH_BREW_HOME}/Cellar"
  export HOMEBREW_REPOSITORY="${BL64_PKG_PATH_BREW_HOME}/Homebrew"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_BREW" $verbose "$@"
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_zypper() {
  bl64_dbg_lib_show_function "$@"
  local verbose="$BL64_PKG_SET_QUIET"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_ZYPPER" $verbose "$@"
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_rpm() {
  bl64_dbg_lib_show_function "$@"
  local verbose='--quiet'

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose='--verbose'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_RPM" $verbose "$@"
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_dpkg() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_PKG_CMD_DPKG" "$@"
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_installer() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose='-verbose'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_INSTALLER" $verbose "$@"
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_softwareupdate() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_PKG_CMD_SOFTWAREUPDATE" "$@"
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
#   0: operation completed ok
#   >0: operation failed
#######################################
function bl64_pkg_run_pacman() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_module 'BL64_PKG_MODULE' &&
    bl64_check_parameters_none "$#" ||
    return $?

  bl64_msg_app_run_is_enabled &&
    verbose="$BL64_PKG_SET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_PACMAN" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

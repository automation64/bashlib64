#######################################
# BashLib64 / Module / Functions / Manage native OS packages
#
# Version: 1.10.0
#######################################

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
#   n: package manager exist status
#######################################
function bl64_pkg_prepare() {
  bl64_dbg_lib_show_function
  local verbose=''

  bl64_check_privilege_root || return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_msg_show_task "$_BL64_PKG_TXT_PREPARE"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    "$BL64_PKG_CMD_DNF" $verbose makecache
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    "$BL64_PKG_CMD_YUM" $verbose makecache
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    export DEBIAN_FRONTEND="noninteractive"
    "$BL64_PKG_CMD_APT" update $verbose
    ;;
  ${BL64_OS_ALP}-*)
    "$BL64_PKG_CMD_APK" update $verbose
    ;;
  ${BL64_OS_MCOS}-*)
    "$BL64_PKG_CMD_BRW" update $verbose
    ;;
  *) bl64_check_show_unsupported ;;
  esac
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
#   n: package manager exist status
#######################################
function bl64_pkg_install() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_privilege_root || return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_msg_show_task "$_BL64_PKG_TXT_INSTALL"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    "$BL64_PKG_CMD_DNF" $verbose ${BL64_PKG_SET_SLIM} ${BL64_PKG_SET_ASSUME_YES} install -- "$@"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    "$BL64_PKG_CMD_YUM" $verbose ${BL64_PKG_SET_ASSUME_YES} install -- "$@"
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    export DEBIAN_FRONTEND="noninteractive"
    "$BL64_PKG_CMD_APT" install $verbose ${BL64_PKG_SET_ASSUME_YES} -- "$@"
    ;;
  ${BL64_OS_ALP}-*)
    "$BL64_PKG_CMD_APK" add $verbose -- "$@"
    ;;
  ${BL64_OS_MCOS}-*)
    "$BL64_PKG_CMD_BRW" install $verbose "$@"
    ;;
  *) bl64_check_show_unsupported ;;

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
#   n: package manager exist status
#######################################
function bl64_pkg_cleanup() {
  bl64_dbg_lib_show_function
  local target=''
  local verbose=''

  bl64_check_privilege_root || return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_msg_show_task "$_BL64_PKG_TXT_CLEAN"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    "$BL64_PKG_CMD_DNF" clean all $verbose
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    "$BL64_PKG_CMD_YUM" clean all $verbose
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    export DEBIAN_FRONTEND="noninteractive"
    "$BL64_PKG_CMD_APT" clean
    ;;
  ${BL64_OS_ALP}-*)
    "$BL64_PKG_CMD_APK" cache clean $verbose
    target='/var/cache/apk'
    if [[ -d "$target" ]]; then
      bl64_fs_rm_full ${target}/[[:alpha:]]*
    fi
    ;;
  ${BL64_OS_MCOS}-*)
    "$BL64_PKG_CMD_BRW" cleanup $verbose --prune=all -s
    ;;
  *) bl64_check_show_unsupported ;;

  esac
}

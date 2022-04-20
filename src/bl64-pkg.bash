#######################################
# BashLib64 / Manage native OS packages
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.8.0
#######################################

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_pkb_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-*)
    BL64_PKG_CMD_DNF='/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    BL64_PKG_CMD_DNF='/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    BL64_PKG_CMD_YUM='/usr/bin/yum'
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_PKG_CMD_APT='/usr/bin/apt-get'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_PKG_CMD_APK='/sbin/apk'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_PKG_CMD_BRW='/opt/homebrew/bin/brew'
    ;;
  *) bl64_msg_show_unsupported ;;
  esac
  # Do not use return as this function gets sourced
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_pkb_set_alias() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-*)
    BL64_PKG_ALIAS_DNF_CACHE="$BL64_PKG_CMD_DNF --color=never makecache"
    BL64_PKG_ALIAS_DNF_INSTALL="$BL64_PKG_CMD_DNF --color=never --nodocs --assumeyes install"
    BL64_PKG_ALIAS_DNF_CLEAN="$BL64_PKG_CMD_DNF clean all"
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    BL64_PKG_ALIAS_DNF_CACHE="$BL64_PKG_CMD_DNF --color=never makecache"
    BL64_PKG_ALIAS_DNF_INSTALL="$BL64_PKG_CMD_DNF --color=never --nodocs --assumeyes install"
    BL64_PKG_ALIAS_DNF_CLEAN="$BL64_PKG_CMD_DNF clean all"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    BL64_PKG_ALIAS_YUM_CACHE="$BL64_PKG_CMD_YUM --color=never makecache"
    BL64_PKG_ALIAS_YUM_INSTALL="$BL64_PKG_CMD_YUM --color=never --assumeyes install"
    BL64_PKG_ALIAS_YUM_CLEAN="$BL64_PKG_CMD_YUM clean all"
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_PKG_ALIAS_APT_UPDATE="$BL64_PKG_CMD_APT update"
    BL64_PKG_ALIAS_APT_INSTALL="$BL64_PKG_CMD_APT --assume-yes install"
    BL64_PKG_ALIAS_APT_CLEAN="$BL64_PKG_CMD_APT clean"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_PKG_ALIAS_APK_INSTALL="$BL64_PKG_CMD_APK add --verbose"
    BL64_PKG_ALIAS_APK_UPDATE="$BL64_PKG_CMD_APK update"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_PKG_ALIAS_BRW_INSTALL="$BL64_PKG_CMD_BRW install"
    BL64_PKG_ALIAS_BRW_CLEAN="$BL64_PKG_CMD_BRW cleanup --prune=all -s"
    BL64_PKG_ALIAS_BRW_UPDATE="$BL64_PKG_CMD_BRW update"
    ;;
  *) bl64_msg_show_unsupported ;;
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
  bl64_check_privilege_root || return $?

  bl64_msg_show_task "$_BL64_PKG_TXT_PREPARE"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-*)
    $BL64_PKG_ALIAS_DNF_CACHE
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    $BL64_PKG_ALIAS_DNF_CACHE
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    $BL64_PKG_ALIAS_YUM_CACHE
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    export DEBIAN_FRONTEND="noninteractive"
    $BL64_PKG_ALIAS_APT_UPDATE
    ;;
  ${BL64_OS_ALP}-*)
    $BL64_PKG_ALIAS_APK_UPDATE
    ;;
  ${BL64_OS_MCOS}-*)
    $BL64_PKG_ALIAS_BRW_UPDATE
    ;;
  *) bl64_msg_show_unsupported ;;
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
  bl64_check_privilege_root || return $?

  bl64_msg_show_task "$_BL64_PKG_TXT_INSTALL"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-*)
    $BL64_PKG_ALIAS_DNF_INSTALL -- "$@"
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    $BL64_PKG_ALIAS_DNF_INSTALL -- "$@"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    $BL64_PKG_ALIAS_YUM_INSTALL -- "$@"
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    export DEBIAN_FRONTEND="noninteractive"
    $BL64_PKG_ALIAS_APT_INSTALL -- "$@"
    ;;
  ${BL64_OS_ALP}-*)
    $BL64_PKG_ALIAS_APK_INSTALL -- "$@"
    ;;
  ${BL64_OS_MCOS}-*)
    $BL64_PKG_ALIAS_BRW_INSTALL "$@"
    ;;
  *) bl64_msg_show_unsupported ;;
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
  local target=''

  bl64_check_privilege_root || return $?

  bl64_msg_show_task "$_BL64_PKG_TXT_CLEAN"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-*)
    $BL64_PKG_ALIAS_DNF_CLEAN
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-8.*)
    $BL64_PKG_ALIAS_DNF_CLEAN
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    $BL64_PKG_ALIAS_YUM_CLEAN
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    export DEBIAN_FRONTEND="noninteractive"
    $BL64_PKG_ALIAS_APT_CLEAN
    ;;
  ${BL64_OS_ALP}-*)
    target='/var/cache/apk'
    if [[ -d "$target" ]]; then
      $BL64_OS_ALIAS_RM_FULL ${target}/[[:alpha:]]*
    fi
    ;;
  ${BL64_OS_MCOS}-*)
    $BL64_PKG_ALIAS_BRW_CLEAN
    ;;
  *) bl64_msg_show_unsupported ;;
  esac
}
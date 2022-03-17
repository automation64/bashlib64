#######################################
# BashLib64 / Manage native OS packages
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.3.0
#######################################

#######################################
# Install packages
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
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exist status
#######################################
function bl64_pkg_prepare() {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    export DEBIAN_FRONTEND="noninteractive"
    $BL64_PKG_ALIAS_APT_UPDATE
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    $BL64_PKG_ALIAS_DNF_CACHE
    ;;
  ${BL64_OS_ALP}-*)
    $BL64_PKG_ALIAS_APK_UPDATE
    ;;
  esac
}

#######################################
# Install packages
#
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exist status
#######################################
function bl64_pkg_install() {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    export DEBIAN_FRONTEND="noninteractive"
    $BL64_PKG_ALIAS_APT_INSTALL -- "$@"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    $BL64_PKG_ALIAS_DNF_INSTALL -- "$@"
    ;;
  ${BL64_OS_ALP}-*)
    $BL64_PKG_ALIAS_APK_INSTALL -- "$@"
    ;;
  esac
}

#######################################
# Clean up the package manager run-time environment
#
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

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    export DEBIAN_FRONTEND="noninteractive"
    $BL64_PKG_ALIAS_APT_CLEAN
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-*)
    $BL64_PKG_ALIAS_DNF_CLEAN
    ;;
  ${BL64_OS_ALP}-*)
    target='/var/cache/apk'
    if [[ -d "$target" ]]; then
      $BL64_OS_ALIAS_RM_FULL ${target}/[[:alpha:]]*
    fi
    ;;
  esac
}

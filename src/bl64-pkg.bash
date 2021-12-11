#######################################
# BashLib64 / Install native OS packages
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.1
#######################################

#######################################
# Initialize the package manager for installations
#
# Globals:
#   BL64_OS_DISTRO
#   BL64_PKG_ALIAS_APT_UPDATE
#   BL64_PKG_ALIAS_DNF_CACHE
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: error from package manager
# Returns:
#   package manager exist status
#######################################
function bl64_pkg_prepare() {

  export LC_ALL="C"

  case "$BL64_OS_DISTRO" in
  UBUNTU-* | DEBIAN-*)
    export DEBIAN_FRONTEND="noninteractive"
    $BL64_PKG_ALIAS_APT_UPDATE
    ;;
  FEDORA-* | CENTOS-* | OL-*)
    $BL64_PKG_ALIAS_DNF_CACHE
    ;;
  esac

}

#######################################
# Install packages
#
# Globals:
#   BL64_OS_DISTRO
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: None
#   STDERR: error from package manager
# Returns:
#   package manager exist status
#######################################
function bl64_pkg_install() {

  export LC_ALL="C"

  case "$BL64_OS_DISTRO" in
  UBUNTU-* | DEBIAN-*)
    export DEBIAN_FRONTEND="noninteractive"
    $BL64_PKG_ALIAS_APT_INSTALL -- "$@"
    ;;
  FEDORA-* | CENTOS-* | OL-*)
    $BL64_PKG_ALIAS_DNF_INSTALL -- "$@"
    ;;
  esac

}

#######################################
# Clean up the package manager run-time environment
#
# Globals:
#   BL64_OS_DISTRO
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: error from package manager
# Returns:
#   package manager exist status
#######################################
function bl64_pkg_cleanup() {

  export LC_ALL="C"

  case "$BL64_OS_DISTRO" in
  UBUNTU-* | DEBIAN-*)
    export DEBIAN_FRONTEND="noninteractive"
    $BL64_PKG_ALIAS_APT_CLEAN
    ;;
  FEDORA-* | CENTOS-* | OL-*)
    $BL64_PKG_ALIAS_DNF_CLEAN
    ;;
  esac

}

#!/bin/bash
#######################################
# Bash library / Shell64 / Identify OS attributes
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/shell64
# Version: 1.0.0
#######################################

#
# Exported Constants
#

#
# Exported Variables
#

declare -gx SHELL64_OS_DISTRO

declare -gx SHELL64_OS_CMD_AWK
declare -gx SHELL64_OS_CMD_CAT
declare -gx SHELL64_OS_CMD_CHMOD
declare -gx SHELL64_OS_CMD_CHOWN
declare -gx SHELL64_OS_CMD_CP
declare -gx SHELL64_OS_CMD_CAT
declare -gx SHELL64_OS_CMD_DATE
declare -gx SHELL64_OS_CMD_HOSTNAME
declare -gx SHELL64_OS_CMD_ID
declare -gx SHELL64_OS_CMD_LS
declare -gx SHELL64_OS_CMD_MKDIR
declare -gx SHELL64_OS_CMD_RM
declare -gx SHELL64_OS_CMD_SUDO
declare -gx SHELL64_OS_CMD_USERADD
declare -gx SHELL64_OS_CMD_APT
declare -gx SHELL64_OS_CMD_DNF
declare -gx SHELL64_OS_CMD_YUM

declare -gx SHELL64_OS_ALIAS_APT_CACHE
declare -gx SHELL64_OS_ALIAS_APT_INSTALL
declare -gx SHELL64_OS_ALIAS_CHOWN_DIR
declare -gx SHELL64_OS_ALIAS_CP_FILE
declare -gx SHELL64_OS_ALIAS_DNF_CACHE
declare -gx SHELL64_OS_ALIAS_DNF_INSTALL
declare -gx SHELL64_OS_ALIAS_ID_USER
declare -gx SHELL64_OS_ALIAS_SUDO_ENV

#
# Internal Variables
#

#
# Internal Functions
#

#
# Exported Functions
#

#######################################
# Identify and normalize Linux OS distribution name and version
#
# Globals:
#   SHELL64_OS_DISTRO
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: ok: always ok, even when unable to identify the platform
#######################################
function shell64_os_get_distro() {

  SHELL64_OS_DISTRO='UNKNOWN'

  if [[ -r '/etc/os-release' ]]; then

    # shellcheck disable=SC1091
    source '/etc/os-release'

    if [[ -n "$ID" && -n "$VERSION_ID" ]]; then
      SHELL64_OS_DISTRO="${ID^^}-${VERSION_ID}"
    fi

  fi

  return 0
}

#######################################
# Identify and normalize common *nix OS commands
# Commands are exported as variables with full path
#
# Globals:
#   SHELL64_OS_DISTRO
#   SHELL64_OS_CMD_AWK
#   SHELL64_OS_CMD_CAT
#   SHELL64_OS_CMD_CHMOD
#   SHELL64_OS_CMD_CHOWN
#   SHELL64_OS_CMD_CP
#   SHELL64_OS_CMD_CAT
#   SHELL64_OS_CMD_DATE
#   SHELL64_OS_CMD_HOSTNAME
#   SHELL64_OS_CMD_ID
#   SHELL64_OS_CMD_LS
#   SHELL64_OS_CMD_MKDIR
#   SHELL64_OS_CMD_RM
#   SHELL64_OS_CMD_SUDO
#   SHELL64_OS_CMD_USERADD
#   SHELL64_OS_CMD_APT
#   SHELL64_OS_CMD_DNF
#   SHELL64_OS_CMD_YUM
# Arguments:
#   STDOUT: None
#   STDERR: None
# Outputs:
#   None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
function shell64_os_set_command() {
  if [[ "$SHELL64_OS_DISTRO" =~ (UBUNTU-.*|FEDORA-.*|CENTOS-.*|OL-.*|DEBIAN-.*) ]]; then
    SHELL64_OS_CMD_AWK='/usr/bin/awk'
    SHELL64_OS_CMD_CAT='/bin/cat'
    SHELL64_OS_CMD_CHMOD='/usr/bin/chmod'
    SHELL64_OS_CMD_CHOWN='/usr/bin/chown'
    SHELL64_OS_CMD_CP='/usr/bin/cp'
    SHELL64_OS_CMD_CAT='/usr/bin/cat'
    SHELL64_OS_CMD_DATE="/usr/bin/date"
    SHELL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
    SHELL64_OS_CMD_LS='/bin/ls'
    SHELL64_OS_CMD_ID='/bin/id'
    SHELL64_OS_CMD_MKDIR='/usr/bin/mkdir'
    SHELL64_OS_CMD_RM='/usr/bin/rm'
    SHELL64_OS_CMD_SUDO='/usr/bin/sudo'
    SHELL64_OS_CMD_USERADD='/usr/sbin/useradd'
  fi
  if [[ "$SHELL64_OS_DISTRO" =~ (UBUNTU-.*|DEBIAN-.*) ]]; then
    SHELL64_OS_CMD_APT='/usr/bin/apt-get'
  fi
  if [[ "$SHELL64_OS_DISTRO" =~ (FEDORA-.*|CENTOS-.*|OL-.*) ]]; then
    SHELL64_OS_CMD_DNF='/usr/bin/dnf'
    SHELL64_OS_CMD_YUM='/usr/bin/yum'
  fi

  return 0
}

#######################################
# Create command aliases for common use cases
# Aliases are presented as regular shell variables for easy inclusion in SUDO
# Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
#
# Globals:
#  SHELL64_OS_ALIAS_APT_CACHE
#  SHELL64_OS_ALIAS_APT_INSTALL
#  SHELL64_OS_ALIAS_CHOWN_DIR
#  SHELL64_OS_ALIAS_CP_FILE
#  SHELL64_OS_ALIAS_DNF_CACHE
#  SHELL64_OS_ALIAS_DNF_INSTALL
#  SHELL64_OS_ALIAS_ID_USER
#  SHELL64_OS_ALIAS_SUDO_ENV
# Arguments:
#   STDOUT: None
#   STDERR: None
# Outputs:
#   None
# Returns:
#   0: always ok
#######################################
function shell64_os_set_alias() {

  SHELL64_OS_ALIAS_ID_USER="$SHELL64_OS_CMD_ID -u -n"
  SHELL64_OS_ALIAS_CP_FILE="$SHELL64_OS_CMD_CP --verbose --force"
  SHELL64_OS_ALIAS_CHOWN_DIR="$SHELL64_OS_CMD_CHOWN --verbose --recursive"
  SHELL64_OS_ALIAS_SUDO_ENV="$SHELL64_OS_CMD_SUDO --preserve-env --set-home"

  if [[ "$SHELL64_OS_DISTRO" =~ (UBUNTU-.*|DEBIAN-.*) ]]; then
    SHELL64_OS_ALIAS_APT_CACHE="$SHELL64_OS_CMD_APT update"
    SHELL64_OS_ALIAS_APT_INSTALL="$SHELL64_OS_CMD_APT --assume-yes install"
  fi

  if [[ "$SHELL64_OS_DISTRO" =~ (FEDORA-.*|CENTOS-.*|OL-.*) ]]; then
    SHELL64_OS_ALIAS_DNF_CACHE="$SHELL64_OS_CMD_DNF --color=never makecache"
    SHELL64_OS_ALIAS_DNF_INSTALL="$SHELL64_OS_CMD_DNF --color=never --nodocs --assumeyes install"
  fi

}

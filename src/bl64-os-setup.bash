#######################################
# BashLib64 / Module / Setup / OS / Identify OS attributes and provide command aliases
#######################################

#
# Internal functions
#

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_os_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_FLAVOR" in
    "$BL64_OS_FLAVOR_DEBIAN")
      BL64_OS_CMD_BASH='/bin/bash'
      BL64_OS_CMD_CAT='/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/bin/false'
      BL64_OS_CMD_HOSTNAME='/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/bin/true'
      BL64_OS_CMD_UNAME='/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_FEDORA" | "$BL64_OS_FLAVOR_REDHAT")
      BL64_OS_CMD_BASH='/bin/bash'
      BL64_OS_CMD_CAT='/usr/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/usr/bin/false'
      BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/usr/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/usr/bin/true'
      BL64_OS_CMD_UNAME='/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_SUSE")
      BL64_OS_CMD_BASH='/usr/bin/bash'
      BL64_OS_CMD_CAT='/usr/bin/cat'
      BL64_OS_CMD_DATE='/usr/bin/date'
      BL64_OS_CMD_FALSE='/usr/bin/false'
      BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/usr/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/usr/bin/true'
      BL64_OS_CMD_UNAME='/usr/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_ALPINE")
      BL64_OS_CMD_BASH='/bin/bash'
      BL64_OS_CMD_CAT='/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/bin/false'
      BL64_OS_CMD_HOSTNAME='/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/bin/true'
      BL64_OS_CMD_UNAME='/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_ARCH")
      BL64_OS_CMD_BASH='/bin/bash'
      BL64_OS_CMD_CAT='/usr/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/usr/bin/false'
      BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
      BL64_OS_CMD_GETENT='/usr/bin/getent'
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/usr/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/usr/bin/true'
      BL64_OS_CMD_UNAME='/bin/uname'
      ;;
    "$BL64_OS_FLAVOR_MACOS")
      # Homebrew used when no native option available
      BL64_OS_CMD_BASH='/opt/homebre/bin/bash'
      BL64_OS_CMD_CAT='/bin/cat'
      BL64_OS_CMD_DATE='/bin/date'
      BL64_OS_CMD_FALSE='/usr/bin/false'
      BL64_OS_CMD_HOSTNAME='/bin/hostname'
      BL64_OS_CMD_GETENT="$BL64_VAR_INCOMPATIBLE"
      BL64_OS_CMD_LOCALE='/usr/bin/locale'
      BL64_OS_CMD_SLEEP='/usr/bin/sleep'
      BL64_OS_CMD_TEE='/usr/bin/tee'
      BL64_OS_CMD_TRUE='/usr/bin/true'
      BL64_OS_CMD_UNAME='/usr/bin/uname'
      ;;
    *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_os_set_options() {
  bl64_dbg_lib_show_function

  BL64_OS_SET_LOCALE_ALL='--all-locales'
}

#######################################
# Set runtime defaults
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_os_set_runtime() {
  bl64_dbg_lib_show_function

  # Reset language to modern specification of C locale
  if bl64_lib_lang_is_enabled; then
    case "$BL64_OS_FLAVOR" in
      "${BL64_OS_FLAVOR_DEBIAN}" | "${BL64_OS_FLAVOR_FEDORA}" | "${BL64_OS_FLAVOR_REDHAT}" | "${BL64_OS_FLAVOR_SUSE}" | "${BL64_OS_FLAVOR_ARCH}")
        bl64_os_set_lang 'C.UTF-8'
        ;;
      "${BL64_OS_FLAVOR_MACOS}" | "${BL64_OS_FLAVOR_ALPINE}")
        bl64_dbg_lib_show_comments 'UTF locale not installed by default, skipping'
        ;;
      *) bl64_check_alert_unsupported ;;
    esac
  fi
}

#######################################
# Obtain OS type
#
# * Used before setting paths, must use plain uname
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: OS Type
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_os_set_type() {
  bl64_dbg_lib_show_function
  BL64_OS_TYPE="$(uname -o)"
  case "$BL64_OS_TYPE" in
    'Darwin') BL64_OS_TYPE="$BL64_OS_TYPE_MACOS" ;;
    'GNU/Linux' | 'Linux') BL64_OS_TYPE="$BL64_OS_TYPE_LINUX" ;;
    *)
      bl64_msg_show_warning \
        "BashLib64 was unable to identify the current OS type (${BL64_OS_TYPE})"
      BL64_OS_TYPE="$BL64_OS_TYPE_UNK"
      ;;
  esac
}

#######################################
# Obtain Machine type
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: OS Type
#   STDERR: command stderr
# Returns:
#   0: operation completed ok
#   >0: operation failed
#######################################
function _bl64_os_set_machine() {
  bl64_dbg_lib_show_function
  local machine=''
  machine="$("$BL64_OS_CMD_UNAME" -m)"
  if [[ -z "$machine" ]]; then
    bl64_msg_show_lib_error 'failed to get machine type from uname'
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi
  case "$machine" in
    'x86_64' | 'amd64') BL64_OS_MACHINE="$BL64_OS_MACHINE_AMD64" ;;
    'aarch64' | 'arm64') BL64_OS_MACHINE="$BL64_OS_MACHINE_ARM64" ;;
    *)
      bl64_msg_show_warning \
        "BashLib64 was unable to identify the current machine type (${machine})"
      # shellcheck disable=SC2034
      BL64_OS_MACHINE="$BL64_OS_MACHINE_UNK"
      ;;
  esac
}

#######################################
# Get normalized OS distro and version from uname
#
# * Warning: bootstrap function
# * Use only for OS that do not have /etc/os-release
# * Normalized data is stored in the global variable BL64_OS_DISTRO
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   >0: error or os not recognized
#######################################
function _bl64_os_get_distro_from_uname() {
  bl64_dbg_lib_show_function
  local os_version=''
  local cmd_sw_vers='/usr/bin/sw_vers'

  case "$BL64_OS_TYPE" in
    "$BL64_OS_TYPE_MACOS")
      os_version="$("$cmd_sw_vers" -productVersion)" &&
        BL64_OS_DISTRO="$(_bl64_os_release_normalize "$BL64_VAR_NONE" "$os_version")" ||
        return $?

      BL64_OS_DISTRO="DARWIN-${BL64_OS_DISTRO}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_MACOS"
      bl64_dbg_lib_show_vars 'BL64_OS_DISTRO'
      ;;
    *)
      BL64_OS_DISTRO="$BL64_OS_UNK"
      bl64_msg_show_lib_error \
        "BashLib64 not supported on the current OS. Please check the OS compatibility matrix (OS: ${BL64_OS_TYPE})"
      return "$BL64_LIB_ERROR_OS_INCOMPATIBLE"
      ;;
  esac
  return 0
}

#######################################
# Get normalized OS distro and version from os-release
#
# * Warning: bootstrap function
# * Normalized data is stored in the global variable BL64_OS_DISTRO
# * Version is normalized to the format: OS_ID-V.S
#   * OS_ID: one of the OS standard tags
#   * V: Major version, number
#   * S: Minor version, number
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   >0: error or os not recognized
#######################################
function _bl64_os_get_distro_from_os_release() {
  bl64_dbg_lib_show_function
  local version_normalized=''
  local os_id=''
  local version_id=''

  _bl64_os_release_load &&
    os_id="${ID:-$BL64_VAR_NONE}" &&
    version_id="${VERSION_ID:-$BL64_VAR_NONE}" &&
    version_normalized="$(_bl64_os_release_normalize "$os_id" "$version_id")" ||
    return $?

  bl64_dbg_lib_show_info 'set BL_OS_DISTRO'
  case "${os_id^^}" in
    'ARCH' | 'CACHYOS' | 'MANJARO')
      bl64_dbg_lib_show_comments "treat all arch based distros as arch (ID=${os_id})"
      BL64_OS_DISTRO="${BL64_OS_ARC}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_ARCH"
      ;;
    'ALMALINUX')
      BL64_OS_DISTRO="${BL64_OS_ALM}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'ALPINE')
      BL64_OS_DISTRO="${BL64_OS_ALP}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_ALPINE"
      ;;
    'AMZN')
      BL64_OS_DISTRO="${BL64_OS_AMZ}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_FEDORA"
      ;;
    'CENTOS')
      BL64_OS_DISTRO="${BL64_OS_CNT}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'DEBIAN')
      BL64_OS_DISTRO="${BL64_OS_DEB}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_DEBIAN"
      ;;
    'FEDORA')
      BL64_OS_DISTRO="${BL64_OS_FD}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_FEDORA"
      ;;
    'DARWIN')
      BL64_OS_DISTRO="${BL64_OS_MCOS}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_MACOS"
      ;;
    'KALI')
      BL64_OS_DISTRO="${BL64_OS_KL}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_DEBIAN"
      ;;
    'OL')
      BL64_OS_DISTRO="${BL64_OS_OL}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'ROCKY')
      BL64_OS_DISTRO="${BL64_OS_RCK}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'RHEL')
      BL64_OS_DISTRO="${BL64_OS_RHEL}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_REDHAT"
      ;;
    'SLES')
      BL64_OS_DISTRO="${BL64_OS_SLES}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_SUSE"
      ;;
    'UBUNTU')
      BL64_OS_DISTRO="${BL64_OS_UB}-${version_normalized}"
      BL64_OS_FLAVOR="$BL64_OS_FLAVOR_DEBIAN"
      ;;
    *)
      bl64_msg_show_lib_error \
        "current OS is not supported. Please check the OS compatibility matrix (ID=${ID:-NONE} | VERSION_ID=${VERSION_ID:-NONE})"
      return "$BL64_LIB_ERROR_OS_INCOMPATIBLE"
      ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_OS_DISTRO' 'BL64_OS_FLAVOR'
  return 0
}

function _bl64_os_release_load() {
  bl64_dbg_lib_show_function
  bl64_dbg_lib_show_info 'parse /etc/os-release'
  # shellcheck disable=SC1091
  if ! source '/etc/os-release'; then
    bl64_msg_show_lib_error 'failed to load OS information from /etc/os-release file'
    return "$BL64_LIB_ERROR_TASK_FAILED"
  fi
  bl64_dbg_lib_show_vars 'ID' 'VERSION_ID'
}

function _bl64_os_release_normalize() {
  bl64_dbg_lib_show_function "$@"
  local os_id="${1:-}"
  local version_raw="${2:-}"
  local version_normalized=''
  local version_pattern_single='^[0-9]+$'
  local version_pattern_major_minor='^[0-9]+\.[0-9]+$'
  local version_pattern_semver='^[0-9]+\.[0-9]+\.[0-9]+$'

  bl64_check_parameter 'os_id' &&
    bl64_check_parameter 'version_raw' ||
    return $?

  bl64_dbg_lib_show_comments 'normalize OS version to match X.Y'
  if [[ "$version_raw" =~ $version_pattern_single ]]; then
    bl64_dbg_lib_show_info "version_pattern_single:  ${version_pattern_single}"
    version_normalized="${version_raw}.0"
  elif [[ "$version_raw" =~ $version_pattern_major_minor ]]; then
    bl64_dbg_lib_show_info "version_pattern_major_minor: ${version_pattern_major_minor}"
    version_normalized="${version_raw}"
  elif [[ "$version_raw" =~ $version_pattern_semver ]]; then
    bl64_dbg_lib_show_info "version_pattern_semver: ${version_pattern_semver}"
    if [[ "${os_id^^}" =~ ^(ARCH|CACHYOS|MANJARO)$ ]]; then
      bl64_dbg_lib_show_comments 'convert version format from YYYYMMDD to YYYY.MM'
      version_normalized="${version_raw:0:4}.${version_raw:4:2}"
    else
      version_normalized="${version_raw%.*}"
    fi
  elif [[ "$version_raw" == "$BL64_VAR_NONE" ]]; then
    bl64_dbg_lib_show_info "no version definition. Assume rolling OS"
    if [[ "${os_id^^}" =~ ^(ARCH|CACHYOS|MANJARO)$ ]]; then
      bl64_dbg_lib_show_info 'define version as the year-month when the OS was added to bl64'
      version_normalized='2025.10'
    fi
  else
    bl64_dbg_lib_show_info "pattern: raw"
    version_normalized="$version_raw"
  fi

  if [[ "$version_normalized" =~ $version_pattern_major_minor ]]; then
    echo "$version_normalized"
    return 0
  fi
  bl64_msg_show_lib_error "unable to normalize OS version (${version_raw} != Major.Minor != ${version_normalized})"
  return "$BL64_LIB_ERROR_TASK_FAILED"
}

#
# Public functions
#

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_os_setup() {
  [[ -z "$BL64_VERSION" ]] && echo 'Error: bashlib64-module-core.bash must be the last sourced library' >&2 && return 21

  [[ "${BASH_VERSINFO[0]}" != '4' && "${BASH_VERSINFO[0]}" != '5' ]] &&
    bl64_msg_show_lib_error "BashLib64 is not supported in the current Bash version (${BASH_VERSINFO[0]})" &&
    return "$BL64_LIB_ERROR_OS_BASH_VERSION"

  # shellcheck disable=SC2034
  _bl64_lib_module_is_imported 'BL64_CHECK_MODULE' &&
    _bl64_lib_module_is_imported 'BL64_DBG_MODULE' &&
    bl64_dbg_lib_show_function &&
    _bl64_lib_module_is_imported 'BL64_MSG_MODULE' &&
    _bl64_os_set_type &&
    _bl64_os_set_distro &&
    _bl64_os_set_runtime &&
    _bl64_os_set_command &&
    _bl64_os_set_options &&
    _bl64_os_set_machine &&
    BL64_OS_MODULE="$BL64_VAR_ON"
  bl64_check_alert_module_setup 'os'
}

#######################################
# Identify and normalize Linux OS distribution name and version
#
# * Warning: bootstrap function
# * OS name format: OOO-V.V
#   * OOO: OS short name (tag)
#   * V.V: Version (Major, Minor)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function _bl64_os_set_distro() {
  bl64_dbg_lib_show_function
  if [[ -r '/etc/os-release' ]]; then
    _bl64_os_get_distro_from_os_release
  else
    _bl64_os_get_distro_from_uname
  fi
}

#######################################
# Set locale related shell variables
#
# * Locale variables are set as is, no extra validation on the locale availability
#
# Arguments:
#   $1: locale name
# Outputs:
#   STDOUT: None
#   STDERR: Validation errors
# Returns:
#   0: set ok
#   >0: set error
#######################################
function bl64_os_set_lang() {
  bl64_dbg_lib_show_function "$@"
  local locale="$1"

  bl64_check_parameter 'locale' || return $?

  LANG="$locale"
  LC_ALL="$locale"
  LANGUAGE="$locale"
  bl64_dbg_lib_show_vars 'LANG' 'LC_ALL' 'LANGUAGE'

  return 0
}

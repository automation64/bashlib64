#######################################
# BashLib64 / Module / Functions / OS / Identify OS attributes and provide command aliases
#
# Version: 3.1.0
#######################################

function _bl64_os_match() {
  bl64_dbg_lib_show_function "$@"
  local target="$1"
  local os=''
  local version=''

  if [[ "$target" == +([[:alpha:]])-+([[:digit:]]).+([[:digit:]]) ]]; then
    os="${target%%-*}"
    version="${target##*-}"
    bl64_dbg_lib_show_info "Pattern: OOO-V.V [${BL64_OS_DISTRO}] == [${os}-${version}]"
    [[ "$BL64_OS_DISTRO" == "${os}-${version}" ]] || return $BL64_LIB_ERROR_OS_NOT_MATCH
  elif [[ "$target" == +([[:alpha:]])-+([[:digit:]]) ]]; then
    os="${target%%-*}"
    version="${target##*-}"
    bl64_dbg_lib_show_info "Pattern: OOO-V [${BL64_OS_DISTRO}] == [${os}-${version}.+([[:digit:]])]"
    [[ "$BL64_OS_DISTRO" == ${os}-${version}.+([[:digit:]]) ]] || return $BL64_LIB_ERROR_OS_NOT_MATCH
  elif [[ "$target" == +([[:alpha:]]) ]]; then
    os="$target"
    bl64_dbg_lib_show_info "Pattern: OOO [${BL64_OS_DISTRO}] == [${os}]"
    [[ "$BL64_OS_DISTRO" == ${os}-+([[:digit:]]).+([[:digit:]]) ]] || return $BL64_LIB_ERROR_OS_NOT_MATCH
  else
    bl64_msg_show_error "${_BL64_OS_TXT_INVALID_OS_PATTERN} (${target})"
    return $BL64_LIB_ERROR_OS_TAG_INVALID
  fi

  return 0
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
  local os_type=''
  local os_version=''
  local cmd_sw_vers='/usr/bin/sw_vers'

  os_type="$(uname)"
  case "$os_type" in
  'Darwin')
    os_version="$("$cmd_sw_vers" -productVersion)"
    BL64_OS_DISTRO="DARWIN-${os_version}"
    ;;
  *) BL64_OS_DISTRO="$BL64_OS_UNK" ;;
  esac

  if [[ "$BL64_OS_DISTRO" == "$BL64_OS_UNK" ]]; then
    bl64_msg_show_error "${_BL64_OS_TXT_OS_NOT_SUPPORTED} ($(uname -a))"
    return $BL64_LIB_ERROR_OS_INCOMPATIBLE
  fi
  bl64_dbg_lib_show_vars 'BL64_OS_DISTRO'

  return 0
}

#######################################
# Get normalized OS distro and version from os-release
#
# * Warning: bootstrap function
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
function _bl64_os_get_distro_from_os_release() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC1091
  source '/etc/os-release'
  if [[ -n "${ID:-}" && -n "${VERSION_ID:-}" ]]; then
    BL64_OS_DISTRO="${ID^^}-${VERSION_ID}"
  fi

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_ALM}-8* | ${BL64_OS_ALM}-9*) : ;;
  ${BL64_OS_ALP}-3*) BL64_OS_DISTRO="${BL64_OS_ALP}-${VERSION_ID%.*}" ;;
  ${BL64_OS_CNT}-7*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_CNT}-7" ]] && BL64_OS_DISTRO="${BL64_OS_CNT}-7.0" ;;
  ${BL64_OS_CNT}-8*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_CNT}-8" ]] && BL64_OS_DISTRO="${BL64_OS_CNT}-8.0" ;;
  ${BL64_OS_CNT}-9*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_CNT}-9" ]] && BL64_OS_DISTRO="${BL64_OS_CNT}-9.0" ;;
  ${BL64_OS_DEB}-9*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-9" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-9.0" ;;
  ${BL64_OS_DEB}-10*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-10" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-10.0" ;;
  ${BL64_OS_DEB}-11*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-11" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-11.0" ;;
  ${BL64_OS_FD}-33*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-33" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-33.0" ;;
  ${BL64_OS_FD}-34*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-34" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-34.0" ;;
  ${BL64_OS_FD}-35*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-35" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-35.0" ;;
  ${BL64_OS_FD}-36*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-36" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-36.0" ;;
  ${BL64_OS_FD}-37*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-37" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-37.0" ;;
  ${BL64_OS_OL}-7* | ${BL64_OS_OL}-8* | ${BL64_OS_OL}-9*) : ;;
  ${BL64_OS_RCK}-8* | ${BL64_OS_RCK}-9*) : ;;
  ${BL64_OS_RHEL}-8* | ${BL64_OS_RHEL}-9*) : ;;
  ${BL64_OS_SLES}-15*)
    # patern:
    #  NAME="SLES"
    #  VERSION_ID="15.4"
    :
    ;;
  ${BL64_OS_UB}-20.* | ${BL64_OS_UB}-21.* | ${BL64_OS_UB}-22.* | ${BL64_OS_UB}-23.*) : ;;
  *) BL64_OS_DISTRO="$BL64_OS_UNK" ;;
  esac

  if [[ "$BL64_OS_DISTRO" == "$BL64_OS_UNK" ]]; then
    bl64_msg_show_error "${_BL64_OS_TXT_FAILED_TO_NORMALIZE_OS} (ID=${ID:-NONE} | VERSION_ID=${VERSION_ID:-NONE}). ${_BL64_OS_TXT_CHECK_OS_MATRIX}"
    return $BL64_LIB_ERROR_OS_INCOMPATIBLE
  fi
  bl64_dbg_lib_show_vars 'BL64_OS_DISTRO'

  return 0
}

#######################################
# Compare the current OS version against a list of OS versions
#
# Arguments:
#   $@: each argument is an OS target. The list is any combintation of the formats: "$BL64_OS_<ALIAS>" "${BL64_OS_<ALIAS>}-V" "${BL64_OS_<ALIAS>}-V.S"
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   BL64_LIB_ERROR_OS_NOT_MATCH
#   BL64_LIB_ERROR_OS_TAG_INVALID
#######################################
function bl64_os_match() {
  bl64_dbg_lib_show_function "$@"
  local item=''
  local -i status=$BL64_LIB_ERROR_OS_NOT_MATCH

  bl64_check_module 'BL64_OS_MODULE' || return $?

  bl64_dbg_lib_show_info "Look for [BL64_OS_DISTRO=${BL64_OS_DISTRO}] in [OSList=${*}}]"
  # shellcheck disable=SC2086
  for item in "$@"; do
    _bl64_os_match "$item"
    status=$?
    ((status == 0)) && break
  done

  # shellcheck disable=SC2086
  return $status
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
# Determine if locale resources for language are installed in the OS
#
# Arguments:
#   $1: locale name
# Outputs:
#   STDOUT: None
#   STDERR: Validation errors
# Returns:
#   0: resources are installed
#   >0: no resources
#######################################
function bl64_os_lang_is_available() {
  bl64_dbg_lib_show_function "$@"
  local locale="$1"
  local line=''

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_parameter 'locale' &&
    bl64_check_command "$BL64_OS_CMD_LOCALE" ||
    return $?

  bl64_dbg_lib_show_info 'look for the requested locale using the locale command'
  IFS=$'\n'
  for line in $("$BL64_OS_CMD_LOCALE" "$BL64_OS_SET_LOCALE_ALL"); do
    unset IFS
    bl64_dbg_lib_show_info "checking [${line}] == [${locale}]"
    [[ "$line" == "$locale" ]] && return 0
  done

  return 1
}

#######################################
# Check the current OS version is in the supported list
#
# * Target use case is script compatibility. Use in the init part to halt execution if OS is not supported
# * Not recommended for checking individual functions. Instead, use if or case structures to support multiple values based on the OS version
# * The check is done against the provided list
# * This is a wrapper to the bl64_os_match so it can be used as a check function
#
# Arguments:
#   $@: list of OS versions to check against. Format: same as bl64_os_match
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#######################################
function bl64_os_check_version() {
  bl64_dbg_lib_show_function "$@"

  bl64_os_match "$@" && return 0

  bl64_msg_show_error "${_BL64_OS_TXT_OS_VERSION_NOT_SUPPORTED} (OS: ${BL64_OS_DISTRO} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_OS_TXT_OS_MATRIX}: ${*})"
  return $BL64_LIB_ERROR_APP_INCOMPATIBLE
}

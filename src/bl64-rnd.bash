#######################################
# BashLib64 / Generate random data
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.1
#######################################

#######################################
# Generate random integer number between min and max
#
# Arguments:
#   $1: Minimum. Default: BL64_RND_RANDOM_MIN
#   $2: Maximum. Default: BL64_RND_RANDOM_MAX
# Outputs:
#   STDOUT: random number
#   STDERR: execution error
# Returns:
#   0: no error
#   >0: printf error
#   BL64_RND_ERROR_MIN
#   BL64_RND_ERROR_MAX
#######################################
function bl64_rnd_get_range() {
  local min="${1:-$BL64_RND_RANDOM_MIN}"
  local max="${2:-$BL64_RND_RANDOM_MAX}"
  local modulo=0

  # shellcheck disable=SC2086
  (( min < BL64_RND_RANDOM_MIN )) && bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MIN $BL64_RND_RANDOM_MIN" && return $BL64_RND_ERROR_MIN
  # shellcheck disable=SC2086
  (( max > BL64_RND_RANDOM_MAX )) && bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MAX $BL64_RND_RANDOM_MAX" && return $BL64_RND_ERROR_MAX

  modulo=$(( max - min + 1))

  printf '%s' "$(( min + (RANDOM % modulo) ))"
}

#######################################
# Generate numeric string
#
# Arguments:
#   $1: Length. Default: BL64_RND_LENGTH_1
# Outputs:
#   STDOUT: random string
#   STDERR: execution error
# Returns:
#   0: no error
#   >0: printf error
#   BL64_RND_ERROR_MIN
#   BL64_RND_ERROR_MAX
#######################################
function bl64_rnd_get_numeric() {
  local length="${1:-$BL64_RND_LENGTH_1}"
  local seed=''

  # shellcheck disable=SC2086
  (( length < BL64_RND_LENGTH_1 )) && bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MIN $BL64_RND_LENGTH_1" && return $BL64_RND_ERROR_MIN
  # shellcheck disable=SC2086
  (( length > BL64_RND_LENGTH_20 )) && bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MAX $BL64_RND_LENGTH_20" && return $BL64_RND_ERROR_MAX

  seed="${RANDOM}${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
  printf '%s' "${seed:0:$length}"
}

#######################################
# Generate alphanumeric string
#
# Arguments:
#   $1: Minimum. Default: BL64_RND_RANDOM_MIN
#   $2: Maximum. Default: BL64_RND_RANDOM_MAX
# Outputs:
#   STDOUT: random string
#   STDERR: execution error
# Returns:
#   0: no error
#   >0: printf error
#   BL64_RND_ERROR_MIN
#   BL64_RND_ERROR_MAX
#######################################
function bl64_rnd_get_alphanumeric() {
  local length="${1:-BL64_RND_LENGTH_1}"
  local output=''
  local item=''
  local index=0
  local count=0

  # shellcheck disable=SC2086
  (( length < BL64_RND_LENGTH_1 )) && bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MIN $BL64_RND_LENGTH_1" && return $BL64_RND_ERROR_MIN
  # shellcheck disable=SC2086
  (( length > BL64_RND_LENGTH_100 )) && bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MAX $BL64_RND_LENGTH_100" && return $BL64_RND_ERROR_MAX

  while (( count < length )); do
    index=$( bl64_rnd_get_range '0' "$BL64_RND_POOL_ALPHANUMERIC_MAX_IDX" )
    item="$( printf '%s' "${BL64_RND_POOL_ALPHANUMERIC:$index:1}" )"
    output="${output}${item}"
    (( count++ ))
  done

  printf '%s' "$output"
}

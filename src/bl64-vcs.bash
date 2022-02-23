#######################################
# BashLib64 / Manage Version Control System
#
# Author: serdigital64 (https://github.com/serdigital64)
# License: GPL-3.0-or-later (https://www.gnu.org/licenses/gpl-3.0.txt)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 1.0.0
#######################################

#######################################
# Clone a remote GIT branch
#
# * File ownership is set to the current user
# * Destination is created if not existing
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: destination path where the repository will be created
#   $3: branch name. Default: main
# Outputs:
#   STDOUT: git output
#   STDERR: git stderr
# Returns:
#   n: git exit status
#   BL64_VCS_ERROR_MISSING_PARAMETER
#   BL64_VCS_ERROR_DESTINATION_ERROR
#######################################
function bl64_vcs_git_clone() {
  local source="${1}"
  local destination="${2}"
  local branch="${3:-main}"

  bl64_check_parameter 'source' 'repository source' || return $BL64_VCS_ERROR_MISSING_PARAMETER
  bl64_check_parameter 'destination' 'repository destination' || return $BL64_VCS_ERROR_MISSING_PARAMETER

  [[ ! -d "$destination" ]] && bl64_os_mkdir_full "$destination"
  bl64_check_directory "$destination" || return $BL64_VCS_ERROR_DESTINATION_ERROR

  cd "$destination" || return $BL64_VCS_ERROR_DESTINATION_ERROR

  "$BL64_VCS_CMD_GIT" \
    clone \
    --depth 1 \
    --single-branch \
    --branch "$branch" \
    "$source"
}

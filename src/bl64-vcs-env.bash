#######################################
# BashLib64 / Module / Globals / Manage Version Control System
#######################################

# shellcheck disable=SC2034
declare BL64_VCS_VERSION='2.0.0'

# shellcheck disable=SC2034
declare BL64_VCS_MODULE='0'

declare BL64_VCS_CMD_GIT=''

declare BL64_VCS_SET_GIT_NO_PAGER=''
declare BL64_VCS_SET_GIT_QUIET=''

#
# GitHub related parameters
#

# GitHub API FQDN
declare BL64_VCS_GITHUB_API_URL='https://api.github.com'
# Target GitHub public API version
declare BL64_VCS_GITHUB_API_VERSION='2022-11-28'
# Special tag for latest release
declare BL64_VCS_GITHUB_LATEST='latest'

declare _BL64_VCS_TXT_CLONE_REPO='clone single branch from GIT repository'
declare _BL64_VCS_TXT_GET_LATEST_RELEASE='get release tag from latest release'
declare _BL64_VCS_TXT_GET_LATEST_RELEASE_FAILED='unable to determine latest release'

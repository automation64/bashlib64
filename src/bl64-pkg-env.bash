#######################################
# BashLib64 / Module / Globals / Manage native OS packages
#######################################

# shellcheck disable=SC2034
declare BL64_PKG_VERSION='5.0.0'

# shellcheck disable=SC2034
declare BL64_PKG_MODULE='0'

declare BL64_PKG_CMD_APK=''
declare BL64_PKG_CMD_APT=''
declare BL64_PKG_CMD_BRW=''
declare BL64_PKG_CMD_DNF=''
declare BL64_PKG_CMD_YUM=''
declare BL64_PKG_CMD_ZYPPER=''

declare BL64_PKG_ALIAS_APK_CLEAN=''
declare BL64_PKG_ALIAS_APK_INSTALL=''
declare BL64_PKG_ALIAS_APK_CACHE=''
declare BL64_PKG_ALIAS_APT_CLEAN=''
declare BL64_PKG_ALIAS_APT_INSTALL=''
declare BL64_PKG_ALIAS_APT_CACHE=''
declare BL64_PKG_ALIAS_BRW_CLEAN=''
declare BL64_PKG_ALIAS_BRW_INSTALL=''
declare BL64_PKG_ALIAS_BRW_CACHE=''
declare BL64_PKG_ALIAS_DNF_CACHE=''
declare BL64_PKG_ALIAS_DNF_CLEAN=''
declare BL64_PKG_ALIAS_DNF_INSTALL=''
declare BL64_PKG_ALIAS_YUM_CACHE=''
declare BL64_PKG_ALIAS_YUM_CLEAN=''
declare BL64_PKG_ALIAS_YUM_INSTALL=''

declare BL64_PKG_SET_ASSUME_YES=''
declare BL64_PKG_SET_QUIET=''
declare BL64_PKG_SET_SLIM=''
declare BL64_PKG_SET_VERBOSE=''

#
# Common paths
#

declare BL64_PKG_PATH_APT_SOURCES_LIST_D=''
declare BL64_PKG_PATH_GPG_KEYRINGS=''
declare BL64_PKG_PATH_YUM_REPOS_D=''

declare BL64_PKG_DEF_SUFIX_APT_REPOSITORY='list'
declare BL64_PKG_DEF_SUFIX_GPG_FILE='gpg'
declare BL64_PKG_DEF_SUFIX_YUM_REPOSITORY='repo'

declare _BL64_PKG_TXT_CLEAN='clean up package manager run-time environment'
declare _BL64_PKG_TXT_INSTALL='install packages'
declare _BL64_PKG_TXT_UPGRADE='upgrade packages'
declare _BL64_PKG_TXT_PREPARE='initialize package manager'
declare _BL64_PKG_TXT_REPOSITORY_REFRESH='refresh package repository content'
declare _BL64_PKG_TXT_REPOSITORY_ADD='add remote package repository'
declare _BL64_PKG_TXT_REPOSITORY_EXISTING='requested repository is already present. Continue using existing one.'
declare _BL64_PKG_TXT_REPOSITORY_ADD_YUM='create YUM repository definition'
declare _BL64_PKG_TXT_REPOSITORY_ADD_APT='create APT repository definition'
declare _BL64_PKG_TXT_REPOSITORY_ADD_KEY='install GPG key'

#######################################
# BashLib64 / Module / Globals / Manage native OS packages
#######################################

export BL64_PKG_VERSION='4.3.3'

declare BL64_PKG_MODULE='0'

export BL64_PKG_CMD_APK=''
export BL64_PKG_CMD_APT=''
export BL64_PKG_CMD_BRW=''
export BL64_PKG_CMD_DNF=''
export BL64_PKG_CMD_YUM=''
export BL64_PKG_CMD_ZYPPER=''

export BL64_PKG_ALIAS_APK_CLEAN=''
export BL64_PKG_ALIAS_APK_INSTALL=''
export BL64_PKG_ALIAS_APK_CACHE=''
export BL64_PKG_ALIAS_APT_CLEAN=''
export BL64_PKG_ALIAS_APT_INSTALL=''
export BL64_PKG_ALIAS_APT_CACHE=''
export BL64_PKG_ALIAS_BRW_CLEAN=''
export BL64_PKG_ALIAS_BRW_INSTALL=''
export BL64_PKG_ALIAS_BRW_CACHE=''
export BL64_PKG_ALIAS_DNF_CACHE=''
export BL64_PKG_ALIAS_DNF_CLEAN=''
export BL64_PKG_ALIAS_DNF_INSTALL=''
export BL64_PKG_ALIAS_YUM_CACHE=''
export BL64_PKG_ALIAS_YUM_CLEAN=''
export BL64_PKG_ALIAS_YUM_INSTALL=''

export BL64_PKG_SET_ASSUME_YES=''
export BL64_PKG_SET_QUIET=''
export BL64_PKG_SET_SLIM=''
export BL64_PKG_SET_VERBOSE=''

#
# Common paths
#

export BL64_PKG_PATH_APT_SOURCES_LIST_D=''
export BL64_PKG_PATH_GPG_KEYRINGS=''
export BL64_PKG_PATH_YUM_REPOS_D=''

export BL64_PKG_DEF_SUFIX_APT_REPOSITORY='list'
export BL64_PKG_DEF_SUFIX_GPG_FILE='gpg'
export BL64_PKG_DEF_SUFIX_YUM_REPOSITORY='repo'

export _BL64_PKG_TXT_CLEAN='clean up package manager run-time environment'
export _BL64_PKG_TXT_INSTALL='install packages'
export _BL64_PKG_TXT_UPGRADE='upgrade packages'
export _BL64_PKG_TXT_PREPARE='initialize package manager'
export _BL64_PKG_TXT_REPOSITORY_REFRESH='refresh package repository content'
export _BL64_PKG_TXT_REPOSITORY_ADD='add remote package repository'
export _BL64_PKG_TXT_REPOSITORY_EXISTING='requested repository is already present. Continue using existing one.'
export _BL64_PKG_TXT_REPOSITORY_ADD_YUM='create YUM repository definition'
export _BL64_PKG_TXT_REPOSITORY_ADD_APT='create APT repository definition'
export _BL64_PKG_TXT_REPOSITORY_ADD_KEY='install GPG key'

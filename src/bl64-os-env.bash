#######################################
# BashLib64 / Module / Globals / OS / Identify OS attributes and provide command aliases
#######################################

export BL64_OS_VERSION='4.3.0'

declare BL64_OS_MODULE='0'

export BL64_OS_DISTRO=''

export BL64_OS_CMD_BASH=''
export BL64_OS_CMD_CAT=''
export BL64_OS_CMD_DATE=''
export BL64_OS_CMD_FALSE=''
export BL64_OS_CMD_HOSTNAME=''
export BL64_OS_CMD_LOCALE=''
export BL64_OS_CMD_TEE=''
export BL64_OS_CMD_TRUE=''
export BL64_OS_CMD_UNAME=''

export BL64_OS_ALIAS_ID_USER=''

export BL64_OS_SET_LOCALE_ALL=''

export _BL64_OS_TXT_CHECK_OS_MATRIX='Please check the OS compatibility matrix for BashLib64'
export _BL64_OS_TXT_ERROR_OS_RELEASE='failed to load OS information from /etc/os-release file'
export _BL64_OS_TXT_INVALID_OS_PATTERN='invalid OS pattern'
export _BL64_OS_TXT_OS_MATRIX='supported-os'
export _BL64_OS_TXT_OS_CURRENT='current-os'
export _BL64_OS_TXT_OS_NOT_KNOWN='current OS is not supported'
export _BL64_OS_TXT_OS_NOT_SUPPORTED='BashLib64 not supported on the current OS'
export _BL64_OS_TXT_OS_VERSION_NOT_SUPPORTED='current OS version is not supported'
export _BL64_OS_TXT_TASK_NOT_SUPPORTED='task not supported on the current OS version'
export _BL64_OS_TXT_COMPATIBILITY_MODE='current OS version is not supported. Execution will continue since compatibility-mode was requested.'

#
# OS standard name tags
#
# * Used to normalize OS names
# * Value format: [A-Z]+
#

export BL64_OS_ALM='ALMALINUX'
export BL64_OS_ALP='ALPINE'
export BL64_OS_AMZ='AMAZONLINUX'
export BL64_OS_CNT='CENTOS'
export BL64_OS_DEB='DEBIAN'
export BL64_OS_FD='FEDORA'
export BL64_OS_MCOS='DARWIN'
export BL64_OS_OL='ORACLELINUX'
export BL64_OS_RCK='ROCKYLINUX'
export BL64_OS_RHEL='RHEL'
export BL64_OS_SLES='SLES'
export BL64_OS_UB='UBUNTU'
export BL64_OS_UNK='UNKNOWN'

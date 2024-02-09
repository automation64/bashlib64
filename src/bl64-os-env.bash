#######################################
# BashLib64 / Module / Globals / OS / Identify OS attributes and provide command aliases
#######################################

# shellcheck disable=SC2034
declare BL64_OS_VERSION='5.1.0'

declare BL64_OS_MODULE='0'

declare BL64_OS_DISTRO=''

declare BL64_OS_CMD_BASH=''
declare BL64_OS_CMD_CAT=''
declare BL64_OS_CMD_DATE=''
declare BL64_OS_CMD_FALSE=''
declare BL64_OS_CMD_HOSTNAME=''
declare BL64_OS_CMD_LOCALE=''
declare BL64_OS_CMD_SLEEP=''
declare BL64_OS_CMD_TEE=''
declare BL64_OS_CMD_TRUE=''
declare BL64_OS_CMD_UNAME=''

declare BL64_OS_SET_LOCALE_ALL=''

declare _BL64_OS_TXT_CHECK_OS_MATRIX='Please check the OS compatibility matrix for BashLib64'
declare _BL64_OS_TXT_ERROR_OS_RELEASE='failed to load OS information from /etc/os-release file'
declare _BL64_OS_TXT_INVALID_OS_PATTERN='invalid OS pattern'
declare _BL64_OS_TXT_OS_MATRIX='supported-os'
declare _BL64_OS_TXT_OS_CURRENT='current-os'
declare _BL64_OS_TXT_OS_NOT_KNOWN='current OS is not supported'
declare _BL64_OS_TXT_OS_NOT_SUPPORTED='BashLib64 not supported on the current OS'
declare _BL64_OS_TXT_OS_VERSION_NOT_SUPPORTED='current OS version is not supported'
declare _BL64_OS_TXT_TASK_NOT_SUPPORTED='task not supported on the current OS version'
declare _BL64_OS_TXT_COMPATIBILITY_MODE='current OS version is not supported. Execution will continue since compatibility-mode was requested.'

#
# OS standard name tags
#
# * Used to normalize OS names
# * Value format: [A-Z]+
#

declare BL64_OS_ALM='ALMALINUX'
declare BL64_OS_ALP='ALPINE'
declare BL64_OS_AMZ='AMAZONLINUX'
declare BL64_OS_CNT='CENTOS'
declare BL64_OS_DEB='DEBIAN'
declare BL64_OS_FD='FEDORA'
declare BL64_OS_MCOS='DARWIN'
declare BL64_OS_OL='ORACLELINUX'
declare BL64_OS_RCK='ROCKYLINUX'
declare BL64_OS_RHEL='RHEL'
declare BL64_OS_SLES='SLES'
declare BL64_OS_UB='UBUNTU'
declare BL64_OS_UNK='UNKNOWN'

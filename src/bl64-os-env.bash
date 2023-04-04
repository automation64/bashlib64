#######################################
# BashLib64 / Module / Globals / OS / Identify OS attributes and provide command aliases
#
# Version: 1.19.0
#######################################

export BL64_OS_MODULE="$BL64_VAR_OFF"

export BL64_OS_DISTRO=''

export BL64_OS_CMD_BASH=''
export BL64_OS_CMD_CAT=''
export BL64_OS_CMD_DATE=''
export BL64_OS_CMD_FALSE=''
export BL64_OS_CMD_HOSTNAME=''
export BL64_OS_CMD_LOCALE=''
export BL64_OS_CMD_TRUE=''
export BL64_OS_CMD_UNAME=''

export BL64_OS_ALIAS_ID_USER=''

# ALM -> AlmaLinux
export BL64_OS_ALM='ALMALINUX'
# ALP -> Alpine Linux
export BL64_OS_ALP='ALPINE'
# AMZ -> Amazon Linux
export BL64_OS_AMZ='AMZN'
# CNT -> CentOS
export BL64_OS_CNT='CENTOS'
# DEB -> Debian
export BL64_OS_DEB='DEBIAN'
# FD  -> Fedora
export BL64_OS_FD='FEDORA'
# MCOS-> MacOS (Darwin)
export BL64_OS_MCOS='DARWIN'
# OL  -> OracleLinux
export BL64_OS_OL='OL'
# RCK -> Rocky Linux
export BL64_OS_RCK='ROCKY'
# RHEL-> RedHat Enterprise Linux
export BL64_OS_RHEL='RHEL'
# SLES-> SUSE Linux Enterprise Server
export BL64_OS_SLES='SLES'
# UB  -> Ubuntu
export BL64_OS_UB='UBUNTU'
# UNK -> Unknown OS
export BL64_OS_UNK='UNKNOWN'

export BL64_OS_SET_LOCALE_ALL=''

export _BL64_OS_TXT_CHECK_OS_MATRIX='Please check that the OS is listed in the current BashLib64 OS compatibility matrix'
export _BL64_OS_TXT_FAILED_TO_NORMALIZE_OS='Unable to normalize OS name and version from /etc/os-release'
export _BL64_OS_TXT_INVALID_OS_PATTERN='invalid OS pattern'
export _BL64_OS_TXT_OS_NOT_SUPPORTED='BashLib64 is not supported in the current OS'
export _BL64_OS_TXT_OS_VERSION_NOT_SUPPORTED='the current OS version is not compatible with the task'
export _BL64_OS_TXT_OS_MATRIX='Supported OS Versions'

#######################################
# BashLib64 / Module / Globals / OS / Identify OS attributes and provide command aliases
#######################################

# shellcheck disable=SC2034
{
  declare BL64_OS_VERSION='5.12.0'

  declare BL64_OS_MODULE='0'

  # Current OS Distro ID
  declare BL64_OS_DISTRO=''

  # Current OS Flavor ID
  declare BL64_OS_FLAVOR=''

  # OS Type, from uname
  declare BL64_OS_TYPE=''

  # Machine ID, from uname
  declare BL64_OS_MACHINE=''

  declare BL64_OS_CMD_BASH=''
  declare BL64_OS_CMD_CAT=''
  declare BL64_OS_CMD_DATE=''
  declare BL64_OS_CMD_FALSE=''
  declare BL64_OS_CMD_GETENT=''
  declare BL64_OS_CMD_HOSTNAME=''
  declare BL64_OS_CMD_LOCALE=''
  declare BL64_OS_CMD_SLEEP=''
  declare BL64_OS_CMD_TEE=''
  declare BL64_OS_CMD_TRUE=''
  declare BL64_OS_CMD_UNAME=''

  declare BL64_OS_SET_LOCALE_ALL=''

  #
  # OS standard name tags
  #
  # * Used to normalize OS names
  # * Value format: [A-Z]+
  #

  declare BL64_OS_ALM='ALMALINUX'
  declare BL64_OS_ALP='ALPINE'
  declare BL64_OS_AMZ='AMAZONLINUX'
  declare BL64_OS_ARC='ARCHLINUX'
  declare BL64_OS_CNT='CENTOS'
  declare BL64_OS_DEB='DEBIAN'
  declare BL64_OS_FD='FEDORA'
  declare BL64_OS_KL='KALI'
  declare BL64_OS_MCOS='DARWIN'
  declare BL64_OS_OL='ORACLELINUX'
  declare BL64_OS_RCK='ROCKYLINUX'
  declare BL64_OS_RHEL='RHEL'
  declare BL64_OS_SLES='SLES'
  declare BL64_OS_UB='UBUNTU'
  declare BL64_OS_UNK='UNKNOWN'

  #
  # OS flavor tags
  #
  # * Flavor defines groups of OS distros that are 100% compatible between them

  declare BL64_OS_FLAVOR_ALPINE='ALPINE'
  declare BL64_OS_FLAVOR_ARCH='ARCH'
  declare BL64_OS_FLAVOR_DEBIAN='DEBIAN'
  declare BL64_OS_FLAVOR_FEDORA='FEDORA'
  declare BL64_OS_FLAVOR_MACOS='MACOS'
  declare BL64_OS_FLAVOR_REDHAT='REDHAT'
  declare BL64_OS_FLAVOR_SUSE='SUSE'

  #
  # OS type tags
  #
  declare BL64_OS_TYPE_LINUX='LINUX'
  declare BL64_OS_TYPE_MACOS='MACOS'
  declare BL64_OS_TYPE_UNK='UNKNOWN'

  #
  # Machine type tags
  #
  declare BL64_OS_MACHINE_AMD64='AMD64'
  declare BL64_OS_MACHINE_ARM64='ARM64'
  declare BL64_OS_MACHINE_UNK='UNKNOWN'
}

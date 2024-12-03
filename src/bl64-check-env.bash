#######################################
# BashLib64 / Module / Globals / Check for conditions and report status
#######################################

# shellcheck disable=SC2034
{
  declare BL64_CHECK_VERSION='6.1.2'

  declare BL64_CHECK_MODULE='0'

  declare _BL64_CHECK_TXT_COMMAND_NOT_FOUND='required command is not present'
  declare _BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE='required command is present but has no execution permission'
  declare _BL64_CHECK_TXT_COMMAND_NOT_INSTALLED='required command is not installed'
  declare _BL64_CHECK_TXT_COMMAND_NOT_IN_PATH='required command is not found in any of the search paths'

  declare _BL64_CHECK_TXT_FILE_NOT_FOUND='required file is not present'
  declare _BL64_CHECK_TXT_FILE_NOT_FILE='path is present but is not a regular file'
  declare _BL64_CHECK_TXT_FILE_NOT_READABLE='required file is present but has no read permission'

  declare _BL64_CHECK_TXT_DIRECTORY_NOT_FOUND='required directory is not present'
  declare _BL64_CHECK_TXT_DIRECTORY_NOT_DIR='path is present but is not a directory'
  declare _BL64_CHECK_TXT_DIRECTORY_NOT_READABLE='required directory is present but has no read permission'

  declare _BL64_CHECK_TXT_EXPORT_EMPTY='required shell exported variable is empty'
  declare _BL64_CHECK_TXT_EXPORT_SET='required shell exported variable is not set'

  declare _BL64_CHECK_TXT_PATH_NOT_FOUND='required path is not present'
  declare _BL64_CHECK_TXT_PATH_NOT_RELATIVE='required path must be relative'
  declare _BL64_CHECK_TXT_PATH_NOT_ABSOLUTE='required path must be absolute'
  declare _BL64_CHECK_TXT_PATH_PRESENT='requested path is already present'

  declare _BL64_CHECK_TXT_PRIVILEGE_IS_NOT_ROOT='the task requires root privilege. Please run the script as root or with SUDO'
  declare _BL64_CHECK_TXT_PRIVILEGE_IS_ROOT='the task should not be run with root privilege. Please run the script as a regular user and not using SUDO'

  declare _BL64_CHECK_TXT_OVERWRITE_NOT_PERMITED='target is already present and overwrite is not permitted. Unable to continue'
}

#######################################
# BashLib64 / Module / Globals / Check for conditions and report status
#
# Version: 1.12.0
#######################################

declare _BL64_CHECK_TXT_MODULE_NOT_SETUP='required bashlib64 module is not setup. Module must be initialized before usage'

declare _BL64_CHECK_TXT_PARAMETER_MISSING='required parameter is missing'
declare _BL64_CHECK_TXT_PARAMETER_NOT_SET='required shell variable is not set'

declare _BL64_CHECK_TXT_COMMAND_NOT_FOUND='required command is not present'
declare _BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE='required command is present but has no execution permission'
declare _BL64_CHECK_TXT_COMMAND_NOT_INSTALLED='required command is not installed'

declare _BL64_CHECK_TXT_FILE_NOT_FOUND='required file is not present'
declare _BL64_CHECK_TXT_FILE_NOT_FILE='path is present but is not a regular file'
declare _BL64_CHECK_TXT_FILE_NOT_READABLE='required file is present but has no read permission'

declare _BL64_CHECK_TXT_DIRECTORY_NOT_FOUND='required directory is not present'
declare _BL64_CHECK_TXT_DIRECTORY_NOT_DIR='path is present but is not a directory'
declare _BL64_CHECK_TXT_DIRECTORY_NOT_READABLE='required directory is present but has no read permission'

declare _BL64_CHECK_TXT_PATH_NOT_FOUND='required path is not present'

declare _BL64_CHECK_TXT_EXPORT_EMPTY='required shell exported variable is empty'
declare _BL64_CHECK_TXT_EXPORT_SET='required shell exported variable is not set'

declare _BL64_CHECK_TXT_PATH_NOT_RELATIVE='required path must be relative'
declare _BL64_CHECK_TXT_PATH_NOT_ABSOLUTE='required path must be absolute'
declare _BL64_CHECK_TXT_PATH_PRESENT='requested path is already present'

declare _BL64_CHECK_TXT_PRIVILEGE_IS_NOT_ROOT='the task requires root privilege. Please run the script as root or with SUDO'
declare _BL64_CHECK_TXT_PRIVILEGE_IS_ROOT='the task should not be run with root privilege. Please run the script as a regular user and not using SUDO'

declare _BL64_CHECK_TXT_OVERWRITE_NOT_PERMITED='the object is already present and overwrite is not permitted'

declare _BL64_CHECK_TXT_INCOMPATIBLE='the requested operation is not supported in the current platform'
declare _BL64_CHECK_TXT_UNDEFINED='requested command is not defined or implemented'
declare _BL64_CHECK_TXT_NOARGS='the requested operation requires at least one parameter and none was provided'

declare _BL64_CHECK_TXT_FUNCTION='caller'

declare _BL64_CHECK_TXT_USER_NOT_FOUND='required user is not present in the operating system'

declare _BL64_CHECK_TXT_STATUS_ERROR='task execution failed'

declare _BL64_CHECK_TXT_I='|'
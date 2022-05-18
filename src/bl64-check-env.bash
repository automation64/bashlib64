#######################################
# BashLib64 / Module / Globals / Check for conditions and report status
#
# Version: 1.9.0
#######################################

readonly _BL64_CHECK_TXT_MODULE_NOT_SETUP='required bashlib64 module is not setup. Module must be initialized before usage'

readonly _BL64_CHECK_TXT_PARAMETER_MISSING='required parameter is missing'
readonly _BL64_CHECK_TXT_PARAMETER_NOT_SET='required shell variable is not set'

readonly _BL64_CHECK_TXT_COMMAND_NOT_FOUND='required command is not present'
readonly _BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE='required command is present but has no execution permission'

readonly _BL64_CHECK_TXT_FILE_NOT_FOUND='required file is not present'
readonly _BL64_CHECK_TXT_FILE_NOT_FILE='path is present but is not a regular file'
readonly _BL64_CHECK_TXT_FILE_NOT_READABLE='required file is present but has no read permission'

readonly _BL64_CHECK_TXT_DIRECTORY_NOT_FOUND='required directory is not present'
readonly _BL64_CHECK_TXT_DIRECTORY_NOT_DIR='path is present but is not a directory'
readonly _BL64_CHECK_TXT_DIRECTORY_NOT_READABLE='required directory is present but has no read permission'

readonly _BL64_CHECK_TXT_PATH_NOT_FOUND='required path is not present'

readonly _BL64_CHECK_TXT_EXPORT_EMPTY='required shell exported variable is empty'
readonly _BL64_CHECK_TXT_EXPORT_SET='required shell exported variable is not set'

readonly _BL64_CHECK_TXT_PATH_NOT_RELATIVE='required path must be relative'
readonly _BL64_CHECK_TXT_PATH_NOT_ABSOLUTE='required path must be absolute'

readonly _BL64_CHECK_TXT_PRIVILEGE_IS_NOT_ROOT='the task requires root privilege. Please run the script as root or with SUDO'
readonly _BL64_CHECK_TXT_PRIVILEGE_IS_ROOT='the task should not be run with root privilege. Please run the script as a regular user and not using SUDO'

readonly _BL64_CHECK_TXT_OVERWRITE_NOT_PERMITED='the object is already present and overwrite is not permitted'

readonly _BL64_CHECK_TXT_INCOMPATIBLE='the requested operation is not supported in the current platform'
readonly _BL64_CHECK_TXT_UNDEFINED='requested command is not defined or implemented'
readonly _BL64_CHECK_TXT_NOARGS='the requested operation requires at least one parameter and none was provided'

readonly _BL64_CHECK_TXT_FUNCTION='caller'

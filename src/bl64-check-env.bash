#######################################
# BashLib64 / Module / Globals / Check for conditions and report status
#######################################

export BL64_CHECK_VERSION='5.0.0'

export BL64_CHECK_MODULE='0'

export _BL64_CHECK_TXT_PARAMETER_MISSING='required parameter is missing'
export _BL64_CHECK_TXT_PARAMETER_NOT_SET='required shell variable is not set'
export _BL64_CHECK_TXT_PARAMETER_DEFAULT='required parameter value must be other than default'
export _BL64_CHECK_TXT_PARAMETER_INVALID='the requested operation was provided with an invalid parameter value'

export _BL64_CHECK_TXT_COMMAND_NOT_FOUND='required command is not present'
export _BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE='required command is present but has no execution permission'
export _BL64_CHECK_TXT_COMMAND_NOT_INSTALLED='required command is not installed'
export _BL64_CHECK_TXT_COMMAND_NOT_IN_PATH='required command is not found in any of the search paths'

export _BL64_CHECK_TXT_FILE_NOT_FOUND='required file is not present'
export _BL64_CHECK_TXT_FILE_NOT_FILE='path is present but is not a regular file'
export _BL64_CHECK_TXT_FILE_NOT_READABLE='required file is present but has no read permission'

export _BL64_CHECK_TXT_DIRECTORY_NOT_FOUND='required directory is not present'
export _BL64_CHECK_TXT_DIRECTORY_NOT_DIR='path is present but is not a directory'
export _BL64_CHECK_TXT_DIRECTORY_NOT_READABLE='required directory is present but has no read permission'

export _BL64_CHECK_TXT_EXPORT_EMPTY='required shell exported variable is empty'
export _BL64_CHECK_TXT_EXPORT_SET='required shell exported variable is not set'

export _BL64_CHECK_TXT_PATH_NOT_FOUND='required path is not present'
export _BL64_CHECK_TXT_PATH_NOT_RELATIVE='required path must be relative'
export _BL64_CHECK_TXT_PATH_NOT_ABSOLUTE='required path must be absolute'
export _BL64_CHECK_TXT_PATH_PRESENT='requested path is already present'

export _BL64_CHECK_TXT_PRIVILEGE_IS_NOT_ROOT='the task requires root privilege. Please run the script as root or with SUDO'
export _BL64_CHECK_TXT_PRIVILEGE_IS_ROOT='the task should not be run with root privilege. Please run the script as a regular user and not using SUDO'

export _BL64_CHECK_TXT_OVERWRITE_NOT_PERMITED='target is already present and overwrite is not permitted. Unable to continue'
export _BL64_CHECK_TXT_OVERWRITE_SKIP_EXISTING='target is already present and overwrite is not requested. Target is left as is'

export _BL64_CHECK_TXT_INCOMPATIBLE='the requested operation is not supported on the current OS'
export _BL64_CHECK_TXT_UNDEFINED='requested command is not defined or implemented'
export _BL64_CHECK_TXT_NOARGS='the requested operation requires at least one parameter and none was provided'
export _BL64_CHECK_TXT_FAILED='task execution failed'

export _BL64_CHECK_TXT_MODULE_SET='required BashLib64 module not found. Please source the module before using it'
export _BL64_CHECK_TXT_MODULE_SETUP_FAILED='failed to setup the requested BashLib64 module'
export _BL64_CHECK_TXT_MODULE_NOT_SETUP='required BashLib64 module is not setup. Call the bl64_<MODULE>_setup function before using the module'

export _BL64_CHECK_TXT_HOME_MISSING='standard shell variable HOME is not defined'
export _BL64_CHECK_TXT_HOME_DIR_MISSING="unable to find user's HOME directory"

export _BL64_CHECK_TXT_RESOURCE_NOT_FOUND='required resource was not found on the system'
export _BL64_CHECK_TXT_STATUS_ERROR='task execution failed'
export _BL64_CHECK_TXT_COMPATIBILITY_MODE='using generic compatibility mode for untested command version'

export _BL64_CHECK_TXT_COMMAND='command'
export _BL64_CHECK_TXT_FILE='file'
export _BL64_CHECK_TXT_PATH='path'
export _BL64_CHECK_TXT_FUNCTION='caller'
export _BL64_CHECK_TXT_MODULE='module'
export _BL64_CHECK_TXT_PARAMETER='parameter'

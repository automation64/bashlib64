#!/usr/bin/env bash
#######################################
# BashLib64 / Bash automation librbary
#
# Author: serdigital64 (https://github.com/serdigital64)
# Repository: https://github.com/serdigital64/bashlib64
# Version: 7.2.0
#
# Copyright 2022 SerDigital64@gmail.com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#######################################

# Do not inherit aliases and commands
unset -f unalias
\unalias -a
unset -f command

# Normalize shtop defaults
shopt -qu \
  'dotglob' \
  'extdebug' \
  'failglob' \
  'globstar' \
  'gnu_errfmt' \
  'huponexit' \
  'lastpipe' \
  'login_shell' \
  'nocaseglob' \
  'nocasematch' \
  'nullglob' \
  'xpg_echo'
shopt -qs \
  'extquote'

# Ensure pipeline exit status is failed when any cmd fails
set -o 'pipefail'

# Enable error processing
set -o 'errtrace'
set -o 'functrace'

# Disable fast-fail. Developer must implement error handling (check for exit status)
set +o 'errexit'

# Reset bash set options to defaults
set -o 'braceexpand'
set -o 'hashall'
set +o 'allexport'
set +o 'histexpand'
set +o 'history'
set +o 'ignoreeof'
set +o 'monitor'
set +o 'noclobber'
set +o 'noglob'
set +o 'nolog'
set +o 'notify'
set +o 'onecmd'
set +o 'posix'

# Do not set/unset - Breaks bats-core
# set -o 'keyword'
# set -o 'noexec'

# Do not inherit sensitive environment variables
unset MAIL
unset ENV
unset IFS
unset TMPDIR

# Normalize terminal settings
TERM="${TERM:-vt100}"

#######################################
# BashLib64 / Module / Globals / Setup script run-time environment
#
# Version: 3.0.0
#######################################

# Declare imported variables
export LANG
export LC_ALL
export LANGUAGE
export TERM

#
# Global flags
#

# Set Command flag (On/Off)
export BL64_LIB_CMD="${BL64_LIB_CMD:-0}"

# Set Strict flag (On/Off)
export BL64_LIB_STRICT="${BL64_LIB_STRICT:-1}"

# Set Traps flag (On/Off)
export BL64_LIB_TRAPS="${BL64_LIB_TRAPS:-1}"

# Set Normalize locale flag
export BL64_LIB_LANG="${BL64_LIB_LANG:-1}"

#
# Common values
#

# Default value for parameters
export BL64_LIB_DEFAULT='_'

# Flag for incompatible command or task
export BL64_LIB_INCOMPATIBLE='_INC_'

# Flag for unavailable command or task
export BL64_LIB_UNAVAILABLE='_UNV_'

# Pseudo null value
export BL64_LIB_VAR_NULL='__'

# Logical values
export BL64_LIB_VAR_TRUE='0'
export BL64_LIB_VAR_FALSE='1'
export BL64_LIB_VAR_ON='1'
export BL64_LIB_VAR_OFF='0'
export BL64_LIB_VAR_OK='0'

#
# Common error codes
#

# Parameters
declare -ig BL64_LIB_ERROR_PARAMETER_INVALID=3
declare -ig BL64_LIB_ERROR_PARAMETER_MISSING=4
declare -ig BL64_LIB_ERROR_PARAMETER_RANGE=5
declare -ig BL64_LIB_ERROR_PARAMETER_EMPTY=6

# Function operation
declare -ig BL64_LIB_ERROR_TASK_FAILED=10
declare -ig BL64_LIB_ERROR_TASK_BACKUP=11
declare -ig BL64_LIB_ERROR_TASK_RESTORE=12
declare -ig BL64_LIB_ERROR_TASK_TEMP=13
declare -ig BL64_LIB_ERROR_TASK_UNDEFINED=14

# Module operation
declare -ig BL64_LIB_ERROR_MODULE_SETUP_INVALID=20
declare -ig BL64_LIB_ERROR_MODULE_SETUP_MISSING=21

# OS
declare -ig BL64_LIB_ERROR_OS_NOT_MATCH=30
declare -ig BL64_LIB_ERROR_OS_TAG_INVALID=31
declare -ig BL64_LIB_ERROR_OS_INCOMPATIBLE=32
declare -ig BL64_LIB_ERROR_OS_BASH_VERSION=33

# External commands
declare -ig BL64_LIB_ERROR_APP_INCOMPATIBLE=40
declare -ig BL64_LIB_ERROR_APP_MISSING=41

# Filesystem
declare -ig BL64_LIB_ERROR_FILE_NOT_FOUND=50
declare -ig BL64_LIB_ERROR_FILE_NOT_READ=51
declare -ig BL64_LIB_ERROR_FILE_NOT_EXECUTE=52
declare -ig BL64_LIB_ERROR_DIRECTORY_NOT_FOUND=53
declare -ig BL64_LIB_ERROR_DIRECTORY_NOT_READ=54
declare -ig BL64_LIB_ERROR_PATH_NOT_RELATIVE=55
declare -ig BL64_LIB_ERROR_PATH_NOT_ABSOLUTE=56
declare -ig BL64_LIB_ERROR_PATH_NOT_FOUND=57
declare -ig BL64_LIB_ERROR_PATH_PRESENT=58

# IAM
declare -ig BL64_LIB_ERROR_PRIVILEGE_IS_ROOT=60
declare -ig BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT=61
declare -ig BL64_LIB_ERROR_USER_NOT_FOUND=62
#declare -ig BL64_LIB_ERROR_GROUP_NOT_FOUND=63

# General
declare -ig BL64_LIB_ERROR_EXPORT_EMPTY=70
declare -ig BL64_LIB_ERROR_EXPORT_SET=71
declare -ig BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED=72

# Script Identify
export BL64_SCRIPT_PATH=''
export BL64_SCRIPT_NAME=''
export BL64_SCRIPT_SID=''
export BL64_SCRIPT_ID=''

# Set Signal traps
export BL64_LIB_SIGNAL_HUP='-'
export BL64_LIB_SIGNAL_STOP='-'
export BL64_LIB_SIGNAL_QUIT='-'
export BL64_LIB_SIGNAL_DEBUG='-'
export BL64_LIB_SIGNAL_ERR='-'
export BL64_LIB_SIGNAL_EXIT='bl64_dbg_runtime_show'
#######################################
# BashLib64 / Module / Globals / Manage archive files
#
# Version: 1.5.0
#######################################

export BL64_ARC_MODULE="$BL64_LIB_VAR_OFF"

export BL64_ARC_CMD_TAR=''
export BL64_ARC_CMD_UNZIP=''

export BL64_ARC_SET_TAR_VERBOSE=''

export BL64_ARC_SET_UNZIP_OVERWRITE=''

export _BL64_ARC_TXT_OPEN_ZIP='open zip archive'
export _BL64_ARC_TXT_OPEN_TAR='open tar archive'

#######################################
# BashLib64 / Module / Functions / Interact with Bash shell
#
# Version: 1.0.0
#######################################

export BL64_BSH_MODULE="$BL64_LIB_VAR_OFF"

export BL64_BSH_VERSION=''

export _BL64_BSH_TXT_UNSUPPORTED='BashLib64 is not supported in the current Bash version'

#######################################
# BashLib64 / Module / Globals / Check for conditions and report status
#
# Version: 1.14.0
#######################################

export _BL64_CHECK_TXT_MODULE_NOT_SETUP='required bashlib64 module is not setup. Module must be initialized before usage'

export _BL64_CHECK_TXT_PARAMETER_MISSING='required parameter is missing'
export _BL64_CHECK_TXT_PARAMETER_NOT_SET='required shell variable is not set'
export _BL64_CHECK_TXT_PARAMETER_DEFAULT='required parameter value must be other than default'

export _BL64_CHECK_TXT_COMMAND_NOT_FOUND='required command is not present'
export _BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE='required command is present but has no execution permission'
export _BL64_CHECK_TXT_COMMAND_NOT_INSTALLED='required command is not installed'

export _BL64_CHECK_TXT_FILE_NOT_FOUND='required file is not present'
export _BL64_CHECK_TXT_FILE_NOT_FILE='path is present but is not a regular file'
export _BL64_CHECK_TXT_FILE_NOT_READABLE='required file is present but has no read permission'

export _BL64_CHECK_TXT_DIRECTORY_NOT_FOUND='required directory is not present'
export _BL64_CHECK_TXT_DIRECTORY_NOT_DIR='path is present but is not a directory'
export _BL64_CHECK_TXT_DIRECTORY_NOT_READABLE='required directory is present but has no read permission'

export _BL64_CHECK_TXT_PATH_NOT_FOUND='required path is not present'

export _BL64_CHECK_TXT_EXPORT_EMPTY='required shell exported variable is empty'
export _BL64_CHECK_TXT_EXPORT_SET='required shell exported variable is not set'

export _BL64_CHECK_TXT_PATH_NOT_RELATIVE='required path must be relative'
export _BL64_CHECK_TXT_PATH_NOT_ABSOLUTE='required path must be absolute'
export _BL64_CHECK_TXT_PATH_PRESENT='requested path is already present'

export _BL64_CHECK_TXT_PRIVILEGE_IS_NOT_ROOT='the task requires root privilege. Please run the script as root or with SUDO'
export _BL64_CHECK_TXT_PRIVILEGE_IS_ROOT='the task should not be run with root privilege. Please run the script as a regular user and not using SUDO'

export _BL64_CHECK_TXT_OVERWRITE_NOT_PERMITED='the object is already present and overwrite is not permitted'

export _BL64_CHECK_TXT_INCOMPATIBLE='the requested operation is not supported in the current platform'
export _BL64_CHECK_TXT_UNDEFINED='requested command is not defined or implemented'
export _BL64_CHECK_TXT_NOARGS='the requested operation requires at least one parameter and none was provided'
export _BL64_CHECK_TXT_FAILED='task execution failed'

export _BL64_CHECK_TXT_PARAMETER_INVALID='the requested operation was provided with an invalid parameter value'

export _BL64_CHECK_TXT_FUNCTION='caller'
export _BL64_CHECK_TXT_PARAMETER='parameter'

export _BL64_CHECK_TXT_USER_NOT_FOUND='required user is not present in the operating system'

export _BL64_CHECK_TXT_STATUS_ERROR='task execution failed'

export _BL64_CHECK_TXT_I='|'
#######################################
# BashLib64 / Module / Globals / Show shell debugging information
#
# Version: 1.9.0
#######################################

export BL64_DBG_MODULE="$BL64_LIB_VAR_OFF"

# Debug target
export BL64_DBG_TARGET=''

#
# Debug targets. Use to select what to debug and how
#
# * ALL_TRACE: Shell tracing for the application and bashlib64
# * APP_TRACE: Shell tracing for selected application functions
# * APP_TASK: Debugging messages from selected application functions
# * APP_CMD: External commands: enable command specific debugging options used in the app
# * APP_CUSTOM_X: Do nothing. Reserved to allow the application define custom debug
# * APP_ALL: Enable full app debugging (task,trace,cmd)
# * LIB_TRACE: Shell tracing for selected bashlib64 functions
# * LIB_TASK: Debugging messages from selected bashlib64 functions
# * LIB_CMD: External commands: enable command specific debugging options used in bashlib64
# * LIB_ALL: Enable full bashlib64 debugging (task,trace,cmd)
#

export BL64_DBG_TARGET_NONE='APP0'
export BL64_DBG_TARGET_APP_TRACE='APP1'
export BL64_DBG_TARGET_APP_TASK='APP2'
export BL64_DBG_TARGET_APP_CMD='APP3'
export BL64_DBG_TARGET_APP_ALL='APP4'
export BL64_DBG_TARGET_APP_CUSTOM_1='CST1'
export BL64_DBG_TARGET_APP_CUSTOM_2='CST2'
export BL64_DBG_TARGET_APP_CUSTOM_3='CST3'
export BL64_DBG_TARGET_LIB_TRACE='LIB1'
export BL64_DBG_TARGET_LIB_TASK='LIB2'
export BL64_DBG_TARGET_LIB_CMD='LIB3'
export BL64_DBG_TARGET_LIB_ALL='LIB4'
export BL64_DBG_TARGET_ALL='ALL'

export _BL64_DBG_TXT_FUNCTION_START='function tracing started'
export _BL64_DBG_TXT_FUNCTION_STOP='function tracing stopped'
export _BL64_DBG_TXT_SHELL_VAR='shell variable'

export _BL64_DBG_TXT_BASH='Bash / Interpreter path'
export _BL64_DBG_TXT_BASHOPTS='Bash / ShOpt Options'
export _BL64_DBG_TXT_SHELLOPTS='Bash / Set -o Options'
export _BL64_DBG_TXT_BASH_VERSION='Bash / Version'
export _BL64_DBG_TXT_OSTYPE='Bash / Detected OS'
export _BL64_DBG_TXT_LC_ALL='Shell / Locale setting'
export _BL64_DBG_TXT_HOSTNAME='Shell / Hostname'
export _BL64_DBG_TXT_EUID='Script / User ID'
export _BL64_DBG_TXT_UID='Script / Effective User ID'
export _BL64_DBG_TXT_BASH_ARGV='Script / Arguments'
export _BL64_DBG_TXT_COMMAND='Script / Last executed command'
export _BL64_DBG_TXT_STATUS='Script / Last exit status'

export _BL64_DBG_TXT_FUNCTION_APP_RUN='run app function with parameters'
export _BL64_DBG_TXT_FUNCTION_LIB_RUN='run bashlib64 function with parameters'

export _BL64_DBG_TXT_CALLSTACK='Last executed function'

export _BL64_DBG_TXT_HOME='Home directory (HOME)'
export _BL64_DBG_TXT_PATH='Search path (PATH)'
export _BL64_DBG_TXT_CD_PWD='Current cd working directory (PWD)'
export _BL64_DBG_TXT_CD_OLDPWD='Previous cd working directory (OLDPWD)'
export _BL64_DBG_TXT_SCRIPT_PATH='Initial script path (BL64_SCRIPT_PATH)'
export _BL64_DBG_TXT_TMPDIR='Temporary path (TMPDIR)'
export _BL64_DBG_TXT_PWD='Current working directory (pwd command)'
export _BL64_DBG_TXT_DEBUG='Debug'

#######################################
# BashLib64 / Module / Globals / Manage local filesystem
#
# Version: 1.9.0
#######################################

export BL64_FS_MODULE="$BL64_LIB_VAR_OFF"

export BL64_FS_PATH_TEMPORAL=''
export BL64_FS_PATH_CACHE=''

export BL64_FS_CMD_CHMOD=''
export BL64_FS_CMD_CHOWN=''
export BL64_FS_CMD_CP=''
export BL64_FS_CMD_FIND=''
export BL64_FS_CMD_LN=''
export BL64_FS_CMD_LS=''
export BL64_FS_CMD_MKDIR=''
export BL64_FS_CMD_MKTEMP=''
export BL64_FS_CMD_MV=''
export BL64_FS_CMD_RM=''
export BL64_FS_CMD_TOUCH=''

export BL64_FS_ALIAS_CHOWN_DIR=''
export BL64_FS_ALIAS_CP_FILE=''
export BL64_FS_ALIAS_LN_SYMBOLIC=''
export BL64_FS_ALIAS_LS_FILES=''
export BL64_FS_ALIAS_MKDIR_FULL=''
export BL64_FS_ALIAS_MV=''
export BL64_FS_ALIAS_RM_FILE=''
export BL64_FS_ALIAS_RM_FULL=''

export BL64_FS_SET_CHMOD_RECURSIVE=''
export BL64_FS_SET_CHMOD_VERBOSE=''
export BL64_FS_SET_CHOWN_RECURSIVE=''
export BL64_FS_SET_CHOWN_VERBOSE=''
export BL64_FS_SET_CP_FORCE=''
export BL64_FS_SET_CP_RECURSIVE=''
export BL64_FS_SET_CP_VERBOSE=''
export BL64_FS_SET_LN_SYMBOLIC=''
export BL64_FS_SET_LN_VERBOSE=''
export BL64_FS_SET_MKDIR_PARENTS=''
export BL64_FS_SET_MKDIR_VERBOSE=''
export BL64_FS_SET_MV_FORCE=''
export BL64_FS_SET_MV_VERBOSE=''
export BL64_FS_SET_RM_FORCE=''
export BL64_FS_SET_RM_RECURSIVE=''
export BL64_FS_SET_RM_VERBOSE=''

export BL64_FS_UMASK_RW_USER='u=rwx,g=,o='
export BL64_FS_UMASK_RW_GROUP='u=rwx,g=rwx,o='
export BL64_FS_UMASK_RW_ALL='u=rwx,g=rwx,o=rwx'
export BL64_FS_UMASK_RW_USER_RO_ALL='u=rwx,g=rx,o=rx'
export BL64_FS_UMASK_RW_GROUP_RO_ALL='u=rwx,g=rwx,o=rx'

export BL64_FS_SAFEGUARD_POSTFIX='.bl64_fs_safeguard'

export _BL64_FS_TXT_SAFEGUARD_FAILED='unable to safeguard requested path'

#######################################
# BashLib64 / Module / Globals / Manage OS identity and access service
#
# Version: 1.5.0
#######################################

export BL64_IAM_MODULE="$BL64_LIB_VAR_OFF"

export BL64_IAM_CMD_USERADD=''
export BL64_IAM_CMD_ID=''

export BL64_IAM_SET_USERADD_HOME_PATH=''
export BL64_IAM_SET_USERADD_CREATE_HOME=''

export BL64_IAM_ALIAS_USERADD=''

export _BL64_IAM_TXT_ADD_USER='create user account'

#######################################
# BashLib64 / Module / Globals / Write messages to logs
#
# Version: 2.0.0
#######################################

# Optional module. Not enabled by default
export BL64_LOG_MODULE="$BL64_LIB_VAR_OFF"

# Log file types
export BL64_LOG_FORMAT_CSV='C'

# Logging categories
export BL64_LOG_CATEGORY_NONE='NONE'
export BL64_LOG_CATEGORY_INFO='INFO'
export BL64_LOG_CATEGORY_DEBUG='DEBUG'
export BL64_LOG_CATEGORY_WARNING='WARNING'
export BL64_LOG_CATEGORY_ERROR='ERROR'

# Parameters
export BL64_LOG_REPOSITORY_MODE='0755'
export BL64_LOG_TARGET_MODE='0644'

# Module variables
export BL64_LOG_FS=''
export BL64_LOG_FORMAT=''
export BL64_LOG_LEVEL=''
export BL64_LOG_REPOSITORY=''
export BL64_LOG_DESTINATION=''
export BL64_LOG_RUNTIME=''

export _BL64_LOG_TXT_INVALID_TYPE='invalid log type. Please use any of BL64_LOG_TYPE_*'
export _BL64_LOG_TXT_SET_TARGET_FAILED='failed to set log target'
export _BL64_LOG_TXT_CREATE_REPOSITORY='create log repository'
#######################################
# BashLib64 / Module / Globals / Display messages
#
# Version: 2.3.0
#######################################

export BL64_MSG_MODULE="$BL64_LIB_VAR_OFF"

# Target verbosity)
export BL64_MSG_VERBOSE=''

#
# Verbosity levels
#
# * 0: nothing is showed
# * 1: application messages only
# * 2: bashlib64 and application messages
#

export BL64_MSG_VERBOSE_NONE='NONE'
export BL64_MSG_VERBOSE_APP='APP'
export BL64_MSG_VERBOSE_LIB='LIB'
export BL64_MSG_VERBOSE_ALL='ALL'

#
# Message type tag
#

export BL64_MSG_TYPE_ERROR='ERROR'
export BL64_MSG_TYPE_WARNING='WARNING'
export BL64_MSG_TYPE_INFO='INFO'
export BL64_MSG_TYPE_INPUT='INPUT'
export BL64_MSG_TYPE_TASK='TASK'
export BL64_MSG_TYPE_LIBTASK='LIBTASK'
export BL64_MSG_TYPE_BATCH='BATCH'
export BL64_MSG_TYPE_BATCHOK='BATCHOK'
export BL64_MSG_TYPE_BATCHERR='BATCHERR'

#
# Message output type
#

export BL64_MSG_OUTPUT_ASCII='A'
export BL64_MSG_OUTPUT_ANSI='N'

# default message output type
export BL64_MSG_OUTPUT=''

#
# Message formats
#

export BL64_MSG_FORMAT_PLAIN='R'
export BL64_MSG_FORMAT_HOST='H'
export BL64_MSG_FORMAT_TIME='T'
export BL64_MSG_FORMAT_CALLER='C'
export BL64_MSG_FORMAT_FULL='F'

# Selected message format
export BL64_MSG_FORMAT="${BL64_MSG_FORMAT:-$BL64_MSG_FORMAT_FULL}"

#
# Message Themes
#

export BL64_MSG_THEME_ASCII_STD_ERROR='(!)'
export BL64_MSG_THEME_ASCII_STD_WARNING='(*)'
export BL64_MSG_THEME_ASCII_STD_INFO='(I)'
export BL64_MSG_THEME_ASCII_STD_INPUT='(?)'
export BL64_MSG_THEME_ASCII_STD_TASK='(-)'
export BL64_MSG_THEME_ASCII_STD_LIBTASK='(-)'
export BL64_MSG_THEME_ASCII_STD_BATCH='(@)'
export BL64_MSG_THEME_ASCII_STD_BATCHOK='(@)'
export BL64_MSG_THEME_ASCII_STD_BATCHERR='(@)'
export BL64_MSG_THEME_ASCII_STD_FMTHOST=''
export BL64_MSG_THEME_ASCII_STD_FMTCALLER=''
export BL64_MSG_THEME_ASCII_STD_FMTTIME=''

export BL64_MSG_THEME_ANSI_STD_ERROR='5;37;41'
export BL64_MSG_THEME_ANSI_STD_WARNING='5;37;43'
export BL64_MSG_THEME_ANSI_STD_INFO='36'
export BL64_MSG_THEME_ANSI_STD_INPUT='5;30;47'
export BL64_MSG_THEME_ANSI_STD_TASK='1;37'
export BL64_MSG_THEME_ANSI_STD_LIBTASK='37'
export BL64_MSG_THEME_ANSI_STD_BATCH='30;1;47'
export BL64_MSG_THEME_ANSI_STD_BATCHOK='30;42'
export BL64_MSG_THEME_ANSI_STD_BATCHERR='5;30;41'
export BL64_MSG_THEME_ANSI_STD_FMTHOST='34'
export BL64_MSG_THEME_ANSI_STD_FMTCALLER='33'
export BL64_MSG_THEME_ANSI_STD_FMTTIME='36'

# Selected message theme
export BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD'

#
# ANSI codes
#

export BL64_MSG_ANSI_FG_BLACK='30'
export BL64_MSG_ANSI_FG_RED='31'
export BL64_MSG_ANSI_FG_GREEN='32'
export BL64_MSG_ANSI_FG_BROWN='33'
export BL64_MSG_ANSI_FG_BLUE='34'
export BL64_MSG_ANSI_FG_PURPLE='35'
export BL64_MSG_ANSI_FG_CYAN='36'
export BL64_MSG_ANSI_FG_LIGHT_GRAY='37'
export BL64_MSG_ANSI_FG_DARK_GRAY='1;30'
export BL64_MSG_ANSI_FG_LIGHT_RED='1;31'
export BL64_MSG_ANSI_FG_LIGHT_GREEN='1;32'
export BL64_MSG_ANSI_FG_YELLOW='1;33'
export BL64_MSG_ANSI_FG_LIGHT_BLUE='1;34'
export BL64_MSG_ANSI_FG_LIGHT_PURPLE='1;35'
export BL64_MSG_ANSI_FG_LIGHT_CYAN='1;36'
export BL64_MSG_ANSI_FG_WHITE='1;37'

export BL64_MSG_ANSI_BG_BLACK='40'
export BL64_MSG_ANSI_BG_RED='41'
export BL64_MSG_ANSI_BG_GREEN='42'
export BL64_MSG_ANSI_BG_BROWN='43'
export BL64_MSG_ANSI_BG_BLUE='44'
export BL64_MSG_ANSI_BG_PURPLE='45'
export BL64_MSG_ANSI_BG_CYAN='46'
export BL64_MSG_ANSI_BG_LIGHT_GRAY='47'
export BL64_MSG_ANSI_BG_DARK_GRAY='1;40'
export BL64_MSG_ANSI_BG_LIGHT_RED='1;41'
export BL64_MSG_ANSI_BG_LIGHT_GREEN='1;42'
export BL64_MSG_ANSI_BG_YELLOW='1;43'
export BL64_MSG_ANSI_BG_LIGHT_BLUE='1;44'
export BL64_MSG_ANSI_BG_LIGHT_PURPLE='1;45'
export BL64_MSG_ANSI_BG_LIGHT_CYAN='1;46'
export BL64_MSG_ANSI_BG_WHITE='1;47'

export BL64_MSG_ANSI_CHAR_NORMAL='0'
export BL64_MSG_ANSI_CHAR_BOLD='1'
export BL64_MSG_ANSI_CHAR_UNDERLINE='4'
export BL64_MSG_ANSI_CHAR_BLINK='5'
export BL64_MSG_ANSI_CHAR_REVERSE='7'

#
# Display messages
#

export _BL64_MSG_TXT_USAGE='Usage'
export _BL64_MSG_TXT_COMMANDS='Commands'
export _BL64_MSG_TXT_FLAGS='Flags'
export _BL64_MSG_TXT_PARAMETERS='Parameters'
export _BL64_MSG_TXT_ERROR='Error'
export _BL64_MSG_TXT_INFO='Info'
export _BL64_MSG_TXT_INPUT='Input'
export _BL64_MSG_TXT_TASK='Task'
export _BL64_MSG_TXT_WARNING='Warning'
export _BL64_MSG_TXT_BATCH='Process'
export _BL64_MSG_TXT_BATCH_START='started'
export _BL64_MSG_TXT_BATCH_FINISH_OK='finished successfully'
export _BL64_MSG_TXT_BATCH_FINISH_ERROR='finished with errors'

#######################################
# BashLib64 / Module / Globals / OS / Identify OS attributes and provide command aliases
#
# Version: 1.14.0
#######################################

export BL64_OS_MODULE="$BL64_LIB_VAR_OFF"

export BL64_OS_DISTRO=''

export BL64_OS_CMD_CAT=''
export BL64_OS_CMD_DATE=''
export BL64_OS_CMD_FALSE=''
export BL64_OS_CMD_HOSTNAME=''
export BL64_OS_CMD_TRUE=''
export BL64_OS_CMD_UNAME=''
export BL64_OS_CMD_BASH=''

export BL64_OS_ALIAS_ID_USER=''

# OS tags. Uppercase version of os-release id
export BL64_OS_TAGS='ALM ALP AMZ CNT DEB FD MCOS OL RCK RHEL UB'; export BL64_OS_TAGS

#   * ALM   -> AlmaLinux
export BL64_OS_ALM='ALMALINUX'; export BL64_OS_ALM
#   * ALP   -> Alpine Linux
export BL64_OS_ALP='ALPINE'; export BL64_OS_ALP
#   * AMZ   -> Amazon Linux
export BL64_OS_AMZ='AMZN'; export BL64_OS_AMZ
#   * CNT   -> CentOS
export BL64_OS_CNT='CENTOS'; export BL64_OS_CNT
#   * DEB   -> Debian
export BL64_OS_DEB='DEBIAN'; export BL64_OS_DEB
#   * FD    -> Fedora
export BL64_OS_FD='FEDORA'; export BL64_OS_FD
#   * MCOS  -> MacOS (Darwin)
export BL64_OS_MCOS='DARWIN'; export BL64_OS_MCOS
#   * OL    -> OracleLinux
export BL64_OS_OL='OL'; export BL64_OS_OL
#   * RCK  -> Rocky Linux
export BL64_OS_RCK='ROCKY'; export BL64_OS_RCK
#   * RHEL  -> RedHat Enterprise Linux
export BL64_OS_RHEL='RHEL'; export BL64_OS_RHEL
#   * UB    -> Ubuntu
export BL64_OS_UB='UBUNTU'; export BL64_OS_UB
#   * UNK    -> Unknown OS
export BL64_OS_UNK='UNKNOWN'; export BL64_OS_UNK

#######################################
# BashLib64 / Module / Globals / Manage native OS packages
#
# Version: 1.10.0
#######################################

export BL64_PKG_MODULE="$BL64_LIB_VAR_OFF"

export BL64_PKG_CMD_APK=''
export BL64_PKG_CMD_APT=''
export BL64_PKG_CMD_BRW=''
export BL64_PKG_CMD_DNF=''
export BL64_PKG_CMD_YUM=''

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

export BL64_PKG_SET_VERBOSE=''

export BL64_PKG_DEF_SUFFIX_YUM_REPOSITORY='repo'

export BL64_PKG_PATH_YUM_REPOS_D=''

export _BL64_PKG_TXT_CLEAN='clean up package manager run-time environment'
export _BL64_PKG_TXT_INSTALL='install packages'
export _BL64_PKG_TXT_UPGRADE='upgrade packages'
export _BL64_PKG_TXT_PREPARE='initialize package manager'
export _BL64_PKG_TXT_REPOSITORY_REFRESH='refresh package repository content'
export _BL64_PKG_TXT_REPOSITORY_ADD='add remote package repository'

#######################################
# BashLib64 / Module / Globals / Interact with system-wide Python
#
# Version: 1.11.1
#######################################

# Optional module. Not enabled by default
export BL64_PY_MODULE="$BL64_LIB_VAR_OFF"

# Define placeholders for optional distro native python versions
export BL64_PY_CMD_PYTHON3="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON35="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON36="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON37="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON38="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON39="$BL64_LIB_UNAVAILABLE"
export BL64_PY_CMD_PYTHON310="$BL64_LIB_UNAVAILABLE"

# Full path to the python venv activated by bl64_py_setup
export BL64_PY_VENV_PATH=''

# Version info
export BL64_PY_VERSION_PYTHON3=''
export BL64_PY_VERSION_PIP3=''

export BL64_PY_SET_PIP_VERBOSE=''
export BL64_PY_SET_PIP_VERSION=''
export BL64_PY_SET_PIP_UPGRADE=''
export BL64_PY_SET_PIP_USER=''
export BL64_PY_SET_PIP_DEBUG=''
export BL64_PY_SET_PIP_QUIET=''
export BL64_PY_SET_PIP_SITE=''
export BL64_PY_SET_PIP_NO_WARN_SCRIPT=''

export BL64_PY_DEF_VENV_CFG=''
export BL64_PY_DEF_MODULE_VENV=''
export BL64_PY_DEF_MODULE_PIP=''

export _BL64_PY_TXT_PIP_PREPARE_PIP='upgrade pip module'
export _BL64_PY_TXT_PIP_PREPARE_SETUP='install and upgrade setuptools modules'
export _BL64_PY_TXT_PIP_CLEANUP_PIP='cleanup pip cache'
export _BL64_PY_TXT_PIP_INSTALL='install modules'
export _BL64_PY_TXT_VENV_MISSING='requested python virtual environment is missing'
export _BL64_PY_TXT_VENV_INVALID='requested python virtual environment is invalid (no pyvenv.cfg found)'
export _BL64_PY_TXT_VENV_CREATE='create python virtual environment'

#######################################
# BashLib64 / Module / Globals / Manage role based access service
#
# Version: 1.5.0
#######################################

export BL64_RBAC_MODULE="$BL64_LIB_VAR_OFF"

export BL64_RBAC_CMD_SUDO=''
export BL64_RBAC_CMD_VISUDO=''
export BL64_RBAC_FILE_SUDOERS=''

export BL64_RBAC_ALIAS_SUDO_ENV=''

export _BL64_RBAC_TXT_INVALID_SUDOERS='the sudoers file is corrupt or invalid'
export _BL64_RBAC_TXT_ADD_ROOT='add password-less root privilege to user'

#######################################
# BashLib64 / Module / Globals / Generate random data
#
# Version: 1.2.0
#######################################

declare -ig BL64_RND_LENGTH_1=1
declare -ig BL64_RND_LENGTH_20=20
declare -ig BL64_RND_LENGTH_100=100
declare -ig BL64_RND_RANDOM_MIN=0
declare -ig BL64_RND_RANDOM_MAX=32767

# shellcheck disable=SC2155
export BL64_RND_POOL_UPPERCASE="$(printf '%b' "$(printf '\\%o' {65..90})")"
export BL64_RND_POOL_UPPERCASE_MAX_IDX="$(( ${#BL64_RND_POOL_UPPERCASE} - 1 ))"
# shellcheck disable=SC2155
export BL64_RND_POOL_LOWERCASE="$(printf '%b' "$(printf '\\%o' {97..122})")"
export BL64_RND_POOL_LOWERCASE_MAX_IDX="$(( ${#BL64_RND_POOL_LOWERCASE} - 1 ))"
# shellcheck disable=SC2155
export BL64_RND_POOL_DIGITS="$(printf '%b' "$(printf '\\%o' {48..57})")"
export BL64_RND_POOL_DIGITS_MAX_IDX="$(( ${#BL64_RND_POOL_DIGITS} - 1 ))"
export BL64_RND_POOL_ALPHANUMERIC="${BL64_RND_POOL_UPPERCASE}${BL64_RND_POOL_LOWERCASE}${BL64_RND_POOL_DIGITS}"
export BL64_RND_POOL_ALPHANUMERIC_MAX_IDX="$(( ${#BL64_RND_POOL_ALPHANUMERIC} - 1 ))"

export _BL64_RND_TXT_LENGHT_MIN='length can not be less than'
export _BL64_RND_TXT_LENGHT_MAX='length can not be greater than'

#######################################
# BashLib64 / Module / Globals / Transfer and Receive data over the network
#
# Version: 1.7.0
#######################################

export BL64_RXTX_MODULE="$BL64_LIB_VAR_OFF"

export BL64_RXTX_CMD_CURL=''
export BL64_RXTX_CMD_WGET=''

export BL64_RXTX_ALIAS_CURL=''
export BL64_RXTX_ALIAS_WGET=''

export BL64_RXTX_SET_CURL_VERBOSE=''
export BL64_RXTX_SET_CURL_OUTPUT=''
export BL64_RXTX_SET_CURL_SILENT=''
export BL64_RXTX_SET_CURL_REDIRECT=''
export BL64_RXTX_SET_CURL_SECURE=''
export BL64_RXTX_SET_WGET_VERBOSE=''
export BL64_RXTX_SET_WGET_OUTPUT=''
export BL64_RXTX_SET_WGET_SECURE=''

export _BL64_RXTX_TXT_MISSING_COMMAND='no web transfer command was found on the system'
export _BL64_RXTX_TXT_EXISTING_DESTINATION='destination path is not empty. No action taken.'
export _BL64_RXTX_TXT_CREATION_PROBLEM='unable to create temporary git repo'
export _BL64_RXTX_TXT_DOWNLOAD_FILE='download file'

#######################################
# BashLib64 / Module / Globals / Manipulate text files content
#
# Version: 1.3.0
#######################################

export BL64_TXT_MODULE="$BL64_LIB_VAR_OFF"

export BL64_TXT_CMD_AWK=''
export BL64_TXT_CMD_CUT=''
export BL64_TXT_CMD_GAWK=''
export BL64_TXT_CMD_GREP=''
export BL64_TXT_CMD_SED=''
export BL64_TXT_CMD_TR=''
export BL64_TXT_CMD_BASE64=''
export BL64_TXT_CMD_ENVSUBST=''

export BL64_TXT_SET_GREP_ERE="$BL64_LIB_UNAVAILABLE"
export BL64_TXT_SET_GREP_INVERT="$BL64_LIB_UNAVAILABLE"
export BL64_TXT_SET_GREP_NO_CASE="$BL64_LIB_UNAVAILABLE"
export BL64_TXT_SET_GREP_SHOW_FILE_ONLY="$BL64_LIB_UNAVAILABLE"

#######################################
# BashLib64 / Module / Globals / User Interface
#
# Version: 1.0.0
#######################################

export BL64_UI_MODULE="$BL64_LIB_VAR_OFF"

export BL64_UI_READ_TIMEOUT='60'

export _BL64_UI_TXT_CONFIRMATION_QUESTION='Please confirm the operation by writting the message'
export _BL64_UI_TXT_CONFIRMATION_MESSAGE='confirm-operation'
export _BL64_UI_TXT_CONFIRMATION_ERROR='provided confirmation message is not what is expected'

#######################################
# BashLib64 / Module / Globals / Manage Version Control System
#
# Version: 2.0.0
#######################################

export BL64_VCS_MODULE="$BL64_LIB_VAR_OFF"

export BL64_VCS_CMD_GIT=''

export BL64_VCS_SET_GIT_NO_PAGER=''
export BL64_VCS_SET_GIT_QUIET=''

export _BL64_VCS_TXT_CLONE_REPO='clone single branch from GIT repository'

#######################################
# BashLib64 / Module / Globals / Manipulate CSV like text files
#
# Version: 1.4.0
#######################################

# Field separators
export BL64_XSV_FS='_@64@_'       # Custom
export BL64_XSV_FS_SPACE=' '
export BL64_XSV_FS_NEWLINE=$'\n'
export BL64_XSV_FS_TAB=$'\t'
export BL64_XSV_FS_COLON=':'
export BL64_XSV_FS_SEMICOLON=';'
export BL64_XSV_FS_COMMA=','
export BL64_XSV_FS_PIPE='|'
export BL64_XSV_FS_AT='@'
export BL64_XSV_FS_DOLLAR='$'
export BL64_XSV_FS_SLASH='/'

export _BL64_XSV_TXT_SOURCE_NOT_FOUND='source file not found'

#######################################
# BashLib64 / Module / Setup / Manage archive files
#
# Version: 1.4.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_arc_setup() {
  bl64_dbg_lib_show_function

  bl64_arc_set_command &&
    bl64_arc_set_options &&
    BL64_ARC_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function bl64_arc_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-*)
    BL64_ARC_CMD_TAR='/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_ARC_CMD_TAR='/usr/bin/tar'
    BL64_ARC_CMD_UNZIP='/usr/bin/unzip'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_arc_set_options() {
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_MCOS}-*)
    BL64_ARC_SET_TAR_VERBOSE='--verbose'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_ARC_SET_TAR_VERBOSE='-v'
    BL64_ARC_SET_UNZIP_OVERWRITE='-o'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Manage archive files
#
# Version: 1.10.0
#######################################

#######################################
# Unzip wrapper debug and common options
#
# * Trust noone. Ignore env args
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_arc_run_unzip() {
  bl64_dbg_lib_show_function "$@"
  local verbosity='-qq'

  bl64_check_module_setup "$BL64_ARC_MODULE" &&
  bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_ARC_CMD_UNZIP" || return $?

  bl64_msg_lib_verbose_enabled && verbosity='-q'
  bl64_dbg_lib_command_enabled && verbosity=' '

  bl64_arc_blank_unzip

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_UNZIP" \
    $verbosity \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_arc_blank_unzip() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited UNZIP* shell variables'
  bl64_dbg_lib_trace_start
  unset UNZIP
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Tar wrapper debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_arc_run_tar() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local debug=''

  bl64_check_module_setup "$BL64_ARC_MODULE" &&
    bl64_check_command "$BL64_ARC_CMD_TAR" ||
    return $?

  bl64_dbg_lib_command_enabled && debug="$BL64_ARC_SET_TAR_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_ARC_CMD_TAR" \
    $debug \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Open tar files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_open_tar() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local -i status=0

  bl64_check_module_setup "$BL64_ARC_MODULE" &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_task "$_BL64_ARC_TXT_OPEN_TAR ($source)"

  # shellcheck disable=SC2164
  cd "$destination"

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    bl64_arc_run_tar \
      --overwrite \
      --extract \
      --no-same-owner \
      --preserve-permissions \
      --no-acls \
      --force-local \
      --auto-compress \
      --file="$source"
    ;;
  ${BL64_OS_ALP}-*)
    bl64_arc_run_tar \
      x \
      --overwrite \
      -f "$source" \
      -o
    ;;
  ${BL64_OS_MCOS}-*)
    bl64_arc_run_tar \
      --extract \
      --no-same-owner \
      --preserve-permissions \
      --no-acls \
      --auto-compress \
      --file="$source"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
  status=$?

  ((status == 0)) && bl64_fs_rm_file "$source"

  return $status
}

#######################################
# Open zip files and remove the source after extraction
#
# * Preserves permissions but not ownership
# * Overwrites destination
# * Ignore ACLs and extended attributes
#
# Arguments:
#   $1: Full path to the source file
#   $2: Full path to the destination
# Outputs:
#   STDOUT: None
#   STDERR: tar or lib error messages
# Returns:
#   BL64_ARC_ERROR_INVALID_DESTINATION
#   tar error status
#######################################
function bl64_arc_open_zip() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local -i status=0

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_directory "$destination" ||
    return $?

  bl64_msg_show_lib_task "$_BL64_ARC_TXT_OPEN_ZIP ($source)"
  bl64_arc_run_unzip \
    $BL64_ARC_SET_UNZIP_OVERWRITE \
    -d "$destination" \
    "$source"
  status=$?

  ((status == 0)) && bl64_fs_rm_file "$source"

  return $status
}

#######################################
# BashLib64 / Module / Functions / Interact with Bash shell
#
# Version: 1.1.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_bsh_setup() {
  bl64_dbg_lib_show_function

  bl64_bsh_set_version ||
    return $?
  BL64_BSH_MODULE="$BL64_LIB_VAR_ON"
}

#######################################
# Identify and set module components versions
#
# * Version information is stored in module global variables
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: command errors
# Returns:
#   0: version set ok
#   >0: command error
#######################################
function bl64_bsh_set_version() {
  bl64_dbg_lib_show_function

  case "${BASH_VERSINFO[0]}" in
  4*) BL64_BSH_VERSION='4.0' ;;
  5*) BL64_BSH_VERSION='5.0' ;;
  *)
    bl64_msg_show_error "${_BL64_BSH_TXT_UNSUPPORTED} (${BASH_VERSINFO[0]})" &&
      return $BL64_LIB_ERROR_OS_BASH_VERSION
    ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_BSH_VERSION'

  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with Bash shell
#
# Version: 1.1.1
#######################################

#######################################
# Get current script location
#
# Arguments:
#   None
# Outputs:
#   STDOUT: full path
#   STDERR: Error messages
# Returns:
#   0: full path
#   >0: command error
#######################################
function bl64_bsh_script_get_path() {
  bl64_dbg_lib_show_function
  local -i main=${#BASH_SOURCE[*]}
  local caller=''

  ((main > 0)) && main=$((main - 1))
  caller="${BASH_SOURCE[${main}]}"

  unset CDPATH &&
    [[ -n "$caller" ]] &&
    cd -- "${caller%/*}" >/dev/null &&
    pwd -P ||
    return $?
}

#######################################
# Get current script name
#
# Arguments:
#   None
# Outputs:
#   STDOUT: script name
#   STDERR: Error messages
# Returns:
#   0: name
#   >0: command error
#######################################
function bl64_bsh_script_get_name() {
  bl64_dbg_lib_show_function
  local -i main=${#BASH_SOURCE[*]}

  ((main > 0)) && main=$((main - 1))

  bl64_fmt_basename "${BASH_SOURCE[${main}]}"

}

#######################################
# Set script ID
#
# * Use to change the default BL64_SCRIPT_ID which is BL64_SCRIPT_NAME
#
# Arguments:
#   $1: id value
# Outputs:
#   STDOUT: script name
#   STDERR: Error messages
# Returns:
#   0: id
#   >0: command error
#######################################
# shellcheck disable=SC2120
function bl64_bsh_script_set_id() {
  bl64_dbg_lib_show_function "$@"
  local script_id="${1:-}"

  bl64_check_parameter 'script_id' || return $?

  BL64_SCRIPT_ID="$script_id"

}

#######################################
# Define current script identity
#
# * BL64_SCRIPT_SID: session ID for the running script. Changes on each run
# * BL64_SCRIPT_PATH: full path to the base directory script
# * BL64_SCRIPT_NAME: file name of the current script
# * BL64_SCRIPT_ID: script id (tag)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Error messages
# Returns:
#   0: identity set
#   >0: failed to set
#######################################
function bl64_bsh_script_set_identity() {
  bl64_dbg_lib_show_function

  BL64_SCRIPT_SID="${BASHPID}${RANDOM}" &&
    BL64_SCRIPT_PATH="$(bl64_bsh_script_get_path)" &&
    BL64_SCRIPT_NAME="$(bl64_bsh_script_get_name)" &&
    bl64_bsh_script_set_id "$BL64_SCRIPT_NAME"

}

#######################################
# Generate a string that can be used to populate shell.env files
#
# * Export format is bash compatible
#
# Arguments:
#   $1: variable name
#   $2: value
# Outputs:
#   STDOUT: export string
#   STDERR: Error messages
# Returns:
#   0: string created
#   >0: creation error
#######################################
function bl64_bsh_env_export_variable() {
  bl64_dbg_lib_show_function "$@"
  local variable="${1:-${BL64_LIB_VAR_NULL}}"
  local value="${2:-}"

  bl64_check_parameter 'variable' ||
    return $?

  printf "export %s='%s'\n" "$variable" "$value"

}

#######################################
# BashLib64 / Module / Functions / Check for conditions and report status
#
# Version: 2.0.1
#######################################

#######################################
# Check and report if the command is present and has execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the command to check
#   $2: Not found error message. Default: _BL64_CHECK_TXT_COMMAND_NOT_FOUND
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Command found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#   $BL64_LIB_ERROR_APP_MISSING
#   $BL64_LIB_ERROR_FILE_NOT_FOUND
#   $BL64_LIB_ERROR_FILE_NOT_EXECUTE
#######################################
function bl64_check_command() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_COMMAND_NOT_FOUND}}"

  bl64_check_parameter 'path' || return $?

  if [[ "$path" == "$BL64_LIB_INCOMPATIBLE" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_INCOMPATIBLE} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_INCOMPATIBLE
  fi

  if [[ "$path" == "$BL64_LIB_UNAVAILABLE" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_COMMAND_NOT_INSTALLED} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_MISSING
  fi

  if [[ ! -e "$path" ]]; then
    bl64_msg_show_error "${message} (command: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  fi

  if [[ ! -x "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE} (command: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_EXECUTE
  fi

  return 0
}

#######################################
# Check and report if the file is present and has read permissions for the current user.
#
# Arguments:
#   $1: Full path to the file
#   $2: Not found error message. Default: _BL64_CHECK_TXT_FILE_NOT_FOUND
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_FILE_NOT_FOUND
#   $BL64_LIB_ERROR_FILE_NOT_READ
#######################################
function bl64_check_file() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_FILE_NOT_FOUND}}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_error "${message} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -f "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_FILE_NOT_FILE} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -r "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_FILE_NOT_READABLE} (file: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_READ
  fi
  return 0
}

#######################################
# Check and report if the directory is present and has read and execute permissions for the current user.
#
# Arguments:
#   $1: Full path to the directory
#   $2: Not found error message. Default: _BL64_CHECK_TXT_DIRECTORY_NOT_FOUND
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
#   $BL64_LIB_ERROR_DIRECTORY_NOT_READ
#######################################
function bl64_check_directory() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_DIRECTORY_NOT_FOUND}}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_error "${message} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
  fi
  if [[ ! -d "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_DIRECTORY_NOT_DIR} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
  fi
  if [[ ! -r "$path" || ! -x "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_DIRECTORY_NOT_READABLE} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_DIRECTORY_NOT_READ
  fi
  return 0
}

#######################################
# Check and report if the path is present
#
# Arguments:
#   $1: Full path to the directory
#   $2: Not found error message. Default: _BL64_CHECK_TXT_PATH_NOT_FOUND
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_FOUND
#######################################
function bl64_check_path() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_PATH_NOT_FOUND}}"

  bl64_check_parameter 'path' || return $?
  if [[ ! -e "$path" ]]; then
    bl64_msg_show_error "${message} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PATH_NOT_FOUND
  fi
  return 0
}

#######################################
# Check for mandatory shell function parameters
#
# * Check that:
#   * variable is defined
#   * parameter is not empty
#   * parameter is not using default value
#   * parameter is not using null value
#
# Arguments:
#   $1: parameter name
#   $2: parameter description. Shown on error messages
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PARAMETER_EMPTY
#######################################
function bl64_check_parameter() {
  bl64_dbg_lib_show_function "$@"
  local parameter_name="${1:-}"
  local description="${2:-parameter: ${parameter_name}}"

  if [[ -z "$parameter_name" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_MISSING} (parameter: parameter_name ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_PARAMETER_EMPTY
  fi

  if [[ ! -v "$parameter_name" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_NOT_SET} (${description} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_PARAMETER_MISSING
  fi

  if eval "[[ -z \"\${${parameter_name}}\" || \"\${${parameter_name}}\" == '${BL64_LIB_VAR_NULL}' ]]"; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_MISSING} (${description} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_PARAMETER_EMPTY
  fi

  if eval "[[ \"\${${parameter_name}}\" == '${BL64_LIB_DEFAULT}' ]]"; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_DEFAULT} (${description} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_PARAMETER_INVALID
  fi
  return 0
}

#######################################
# Check shell exported environment variable:
#   - exported variable is not empty
#   - exported variable is set
#
# Arguments:
#   $1: parameter name
#   $2: parameter description. Shown on error messages
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: Check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_EXPORT_EMPTY
#   $BL64_LIB_ERROR_EXPORT_SET
#######################################
function bl64_check_export() {
  bl64_dbg_lib_show_function "$@"
  local export_name="${1:-}"
  local description="${2:-export: $export_name}"

  if [[ ! -v "$export_name" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_EXPORT_SET} (${description} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_EXPORT_SET
  fi

  if eval "[[ -z \$${export_name} ]]"; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_EXPORT_EMPTY} (${description} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_EXPORT_EMPTY
  fi
  return 0
}

#######################################
# Check that the given path is relative
#
# * String check only
# * Path is not tested for existance
#
# Arguments:
#   $1: Path string
#   $2: Failed check error message. Default: _BL64_CHECK_TXT_PATH_NOT_RELATIVE
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_RELATIVE
#######################################
function bl64_check_path_relative() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_PATH_NOT_RELATIVE}}"

  bl64_check_parameter 'path' || return $?
  if [[ "$path" == '/' || "$path" == /* ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PATH_NOT_RELATIVE} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PATH_NOT_RELATIVE
  fi
  return 0
}

#######################################
# Check that the given path is not present
#
# Arguments:
#   $1: Full path
#   $2: Failed check error message. Default: _BL64_CHECK_TXT_PATH_PRESENT
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_PRESENT
#######################################
function bl64_check_path_not_present() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_PATH_PRESENT}}"

  bl64_check_parameter 'path' || return $?
  if [[ -e "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PATH_PRESENT} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PATH_PRESENT
  fi
  return 0
}

#######################################
# Check that the given path is absolute
#
# * String check only
# * Path is not tested for existance
#
# Arguments:
#   $1: Path string
#   $2: Failed check error message. Default: _BL64_CHECK_TXT_PATH_NOT_ABSOLUTE
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: File found
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_PATH_NOT_ABSOLUTE
#######################################
function bl64_check_path_absolute() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_PATH_NOT_ABSOLUTE}}"

  bl64_check_parameter 'path' || return $?
  if [[ "$path" != '/' && "$path" != /* ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PATH_NOT_ABSOLUTE} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PATH_NOT_ABSOLUTE
  fi
  return 0
}

#######################################
# Check that the effective user running the current process is root
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_PRIVILEGE_IS_ROOT
#######################################
function bl64_check_privilege_root() {
  bl64_dbg_lib_show_function
  if [[ "$EUID" != '0' ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PRIVILEGE_IS_NOT_ROOT} (current id: $EUID ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT
  fi
  return 0
}

#######################################
# Check that the effective user running the current process is not root
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT
#######################################
function bl64_check_privilege_not_root() {
  bl64_dbg_lib_show_function

  if [[ "$EUID" == '0' ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PRIVILEGE_IS_ROOT} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PRIVILEGE_IS_ROOT
  fi
  return 0
}

#######################################
# Check file/dir overwrite condition
#
# Arguments:
#   $1: Full path to the object
#   $2: Overwrite flag. Must be ON(1) or OFF(0). Default: OFF
#   $3: Error message
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_PARAMETER_MISSING
#   $BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED
#######################################
function bl64_check_overwrite() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local overwrite="${2:-"$BL64_LIB_VAR_OFF"}"
  local message="${3:-${_BL64_CHECK_TXT_OVERWRITE_NOT_PERMITED}}"

  bl64_check_parameter 'path' || return $?

  if [[ "$overwrite" == "$BL64_LIB_VAR_OFF" || "$overwrite" == "$BL64_LIB_DEFAULT" ]]; then
    if [[ -e "$path" ]]; then
      bl64_msg_show_error "${message} (path: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
      # shellcheck disable=SC2086
      return $BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED
    fi
  fi

  return 0
}

#######################################
# Raise error: invalid parameter
#
# * Use to raise an error when the calling function has verified that the parameter is not valid
# * This is a generic enough message to capture most validation use cases when there is no specific bl64_check_*
# * Can be used as the default value (*) for the bash command "case" to capture invalid options
#
# Arguments:
#   $1: parameter name
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
# shellcheck disable=SC2120
function bl64_check_alert_parameter_invalid() {
  bl64_dbg_lib_show_function "$@"
  local parameter="${1:-${BL64_LIB_DEFAULT}}"
  local message="${2:-${_BL64_CHECK_TXT_PARAMETER_INVALID}}"

  [[ "$parameter" == "$BL64_LIB_DEFAULT" ]] && parameter=''
  bl64_msg_show_error "${message} (${parameter:+${_BL64_CHECK_TXT_PARAMETER}: ${parameter}}${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
  return $BL64_LIB_ERROR_PARAMETER_INVALID
}

#######################################
# Raise unsupported platform error
#
# Arguments:
#   None
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_OS_INCOMPATIBLE
#######################################
function bl64_check_alert_unsupported() {
  bl64_dbg_lib_show_function

  bl64_msg_show_error "${_BL64_CHECK_TXT_INCOMPATIBLE} (os: ${BL64_OS_DISTRO} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
  return $BL64_LIB_ERROR_OS_INCOMPATIBLE
}

#######################################
# Raise undefined command error
#
# * Commonly used in the default branch of case statements to catch undefined options
#
# Arguments:
#   $1: command
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
# shellcheck disable=SC2119,SC2120
function bl64_check_alert_undefined() {
  bl64_dbg_lib_show_function "$@"
  local target="${1:-}"

  bl64_msg_show_error "${_BL64_CHECK_TXT_UNDEFINED} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE}${target:+ ${_BL64_CHECK_TXT_I} command: ${target}})"
  return $BL64_LIB_ERROR_TASK_UNDEFINED
}

#######################################
# Check that parameters are passed
#
# Arguments:
#   $1: total number of parameters from the calling function ($#)
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
function bl64_check_parameters_none() {
  bl64_dbg_lib_show_function "$@"
  local count="${1:-0}"

  if [[ "$count" == '0' ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_NOARGS} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_PARAMETER_MISSING
  else
    return 0
  fi
}

#######################################
# Check that the optional module is loaded
#
# Arguments:
#   $1: load status (eg: $BL64_XXXX_MODULE)
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
function bl64_check_module_setup() {
  bl64_dbg_lib_show_function "$@"
  local setup_status="${1:-}"

  bl64_check_parameter 'setup_status' || return $?

  if [[ "$setup_status" == "$BL64_LIB_VAR_OFF" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_MODULE_NOT_SETUP} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_MODULE_SETUP_MISSING
  else
    return 0
  fi
}

#######################################
# Check that the user is created
#
# Arguments:
#   $1: user name
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_USER_NOT_FOUND
#######################################
function bl64_check_user() {
  bl64_dbg_lib_show_function "$@"
  local user="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_USER_NOT_FOUND}}"

  bl64_check_parameter 'user' || return $?

  if ! bl64_iam_user_is_created "$user"; then
    bl64_msg_show_error "${message} (user: ${user} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_USER_NOT_FOUND
  else
    return 0
  fi
}

#######################################
# Check exit status
#
# * Helper to check for exit status of the last executed command and show error if failed
# * Return the same status as the latest command. This is to facilitate chaining with &&
#
# Arguments:
#   $1: exit status
#   $2: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   $status
#######################################
function bl64_check_status() {
  bl64_dbg_lib_show_function "$@"
  local status="${1:-}"
  local message="${2:-${_BL64_CHECK_TXT_STATUS_ERROR}}"

  bl64_check_parameter 'status' || return $?

  if [[ "$status" != '0' ]]; then
    bl64_msg_show_error "${message} (status: ${status} ${_BL64_CHECK_TXT_I} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return "$status"
  else
    return 0
  fi
}

#######################################
# Check that the HOME variable is present and the path is valid
#
# * HOME is the standard shell variable for current user's home
#
# Arguments:
#   None
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: home is valid
#   >0: home is not valid
#######################################
function bl64_check_home() {
  bl64_dbg_lib_show_function

  bl64_check_export 'HOME' &&
    bl64_check_directory "$HOME"
}

#######################################
# BashLib64 / Module / Setup / Show shell debugging inlevelion
#
# Version: 1.2.0
#######################################

#
# Individual debugging level status
#
function bl64_dbg_app_task_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_TASK" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_task_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_TASK" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_command_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CMD" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_command_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_CMD" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_trace_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_TRACE" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_ALL" ]]; }
function bl64_dbg_lib_trace_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_ALL" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_TRACE" || "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_LIB_ALL" ]]; }
function bl64_dbg_app_custom_1_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CUSTOM_1" ]]; }
function bl64_dbg_app_custom_2_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CUSTOM_2" ]]; }
function bl64_dbg_app_custom_3_enabled { [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CUSTOM_3" ]]; }

#
# Individual debugging level control
#
function bl64_dbg_all_disable { BL64_DBG_TARGET="$BL64_DBG_TARGET_NONE"; }
function bl64_dbg_all_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_ALL"; }
function bl64_dbg_app_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_ALL"; }
function bl64_dbg_lib_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_ALL"; }
function bl64_dbg_app_task_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_TASK"; }
function bl64_dbg_lib_task_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_TASK"; }
function bl64_dbg_app_command_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CMD"; }
function bl64_dbg_lib_command_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_CMD"; }
function bl64_dbg_app_trace_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_TRACE"; }
function bl64_dbg_lib_trace_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_LIB_TRACE"; }
function bl64_dbg_app_custom_1_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CUSTOM_1"; }
function bl64_dbg_app_custom_2_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CUSTOM_2"; }
function bl64_dbg_app_custom_3_enable { BL64_DBG_TARGET="$BL64_DBG_TARGET_APP_CUSTOM_3"; }

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_dbg_setup() {
  bl64_dbg_lib_show_function

  # Set default debug level
  bl64_dbg_all_disable

  BL64_DBG_MODULE="$BL64_LIB_VAR_ON"
}

#######################################
# Set debugging level
#
# Arguments:
#   $1: target level. One of BL64_DBG_TARGET_*
# Outputs:
#   STDOUT: None
#   STDERR: check error
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_dbg_set_level() {
  local level="$1"

  bl64_check_parameter 'level' || return $?

  case "$level" in
  "$BL64_DBG_TARGET_NONE") bl64_dbg_all_disable ;;
  "$BL64_DBG_TARGET_APP_TRACE") bl64_dbg_app_trace_enable ;;
  "$BL64_DBG_TARGET_APP_TASK") bl64_dbg_app_task_enable ;;
  "$BL64_DBG_TARGET_APP_CMD") bl64_dbg_app_command_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_1" ) bl64_dbg_app_custom_1_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_2" ) bl64_dbg_app_custom_2_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_3" ) bl64_dbg_app_custom_3_enable ;;
  "$BL64_DBG_TARGET_APP_ALL") bl64_dbg_app_enable ;;
  "$BL64_DBG_TARGET_LIB_TRACE") bl64_dbg_lib_trace_enable ;;
  "$BL64_DBG_TARGET_LIB_TASK") bl64_dbg_lib_task_enable ;;
  "$BL64_DBG_TARGET_LIB_CMD") bl64_dbg_lib_command_enable ;;
  "$BL64_DBG_TARGET_LIB_ALL") bl64_dbg_lib_enable ;;
  "$BL64_DBG_TARGET_ALL") bl64_dbg_all_enable ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Show shell debugging information
#
# Version: 2.0.0
#######################################

function _bl64_dbg_show() {
  local message="$1"

  printf '%s: %s\n' "$_BL64_DBG_TXT_DEBUG" "$message" >&2
}

#######################################
# Show runtime info
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: runtime info
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show() {
  local -i last_status=$?

  if [[ "$BL64_DBG_TARGET" == "$BL64_DBG_TARGET_APP_CMD" ]]; then
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_BASH}: [${BASH}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_BASHOPTS}: [${BASHOPTS:-NONE}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_SHELLOPTS}: [${SHELLOPTS:-NONE}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_BASH_VERSION}: [${BASH_VERSION}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_OSTYPE}: [${OSTYPE:-NONE}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_LC_ALL}: [${LC_ALL:-NONE}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_HOSTNAME}: [${HOSTNAME:-EMPTY}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_EUID}: [${EUID}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_UID}: [${UID}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_BASH_ARGV}: [${BASH_ARGV[*]:-NONE}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_COMMAND}: [${BASH_COMMAND:-NONE}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_STATUS}: [${last_status}]"

    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_SCRIPT_PATH}: [${BL64_SCRIPT_PATH:-EMPTY}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_HOME}: [${HOME:-EMPTY}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_PATH}: [${PATH:-EMPTY}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_CD_PWD}: [${PWD:-EMPTY}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_CD_OLDPWD}: [${OLDPWD:-EMPTY}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_PWD}: [$(pwd)]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_TMPDIR}: [${TMPDIR:-NONE}]"

    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_CALLSTACK}(1): [${BASH_SOURCE[1]:-NONE}:${FUNCNAME[1]:-NONE}:${BASH_LINENO[1]:-0}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_CALLSTACK}(2): [${BASH_SOURCE[2]:-NONE}:${FUNCNAME[2]:-NONE}:${BASH_LINENO[2]:-0}]"
    _bl64_dbg_show "[bash] ${_BL64_DBG_TXT_CALLSTACK}(3): [${BASH_SOURCE[3]:-NONE}:${FUNCNAME[3]:-NONE}:${BASH_LINENO[3]:-0}]"
  fi

  # shellcheck disable=SC2248
  return $last_status
}

#######################################
# Show runtime call stack
#
# * Show previous 3 functions from the current caller
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: callstack
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show_callstack() {
  bl64_dbg_app_task_enabled || bl64_dbg_lib_task_enabled || return 0
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_CALLSTACK}(2): [${BASH_SOURCE[1]:-NONE}:${FUNCNAME[2]:-NONE}:${BASH_LINENO[2]:-0}]"
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_CALLSTACK}(3): [${BASH_SOURCE[2]:-NONE}:${FUNCNAME[3]:-NONE}:${BASH_LINENO[3]:-0}]"
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_CALLSTACK}(4): [${BASH_SOURCE[3]:-NONE}:${FUNCNAME[4]:-NONE}:${BASH_LINENO[4]:-0}]"
}

#######################################
# Show runtime paths
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: callstack
# Returns:
#   latest exit status (before function call)
#######################################
function bl64_dbg_runtime_show_paths() {
  bl64_dbg_app_task_enabled || bl64_dbg_lib_task_enabled || return 0
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_SCRIPT_PATH}: [${BL64_SCRIPT_PATH:-EMPTY}]"
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_HOME}: [${HOME:-EMPTY}]"
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_PATH}: [${PATH:-EMPTY}]"
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_CD_PWD}: [${PWD:-EMPTY}]"
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_CD_OLDPWD}: [${OLDPWD:-EMPTY}]"
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_PWD}: [$(pwd)]"
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_TMPDIR}: [${TMPDIR:-NONE}]"
}

#######################################
# Stop app  shell tracing
#
# * Saves the last exit status so the function will not disrupt the error flow
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_trace_stop() {
  local -i state=$?

  bl64_dbg_app_trace_enabled || return $state

  set +x
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_STOP}"

  return $state
}

#######################################
# Start app  shell tracing if target is in scope
#
# Arguments:
#   None
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_trace_start() {
  bl64_dbg_app_trace_enabled || return 0

  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_START}"
  set -x

  return 0
}

#######################################
# Stop bashlib64 shell tracing
#
# * Saves the last exit status so the function will not disrupt the error flow
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   Saved exit status
#######################################
function bl64_dbg_lib_trace_stop() {
  local -i state=$?

  bl64_dbg_lib_trace_enabled || return $state

  set +x
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_STOP}"

  return $state
}

#######################################
# Start bashlib64 shell tracing if target is in scope
#
# Arguments:
#   None
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_trace_start() {
  bl64_dbg_lib_trace_enabled || return 0

  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_START}"
  set -x

  return 0
}

#######################################
# Show bashlib64 task level debugging information
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_info() {
  [[ "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_ALL" && "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_LIB_TASK" && "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_LIB_ALL" || "$#" == '0' ]] &&
    return 0
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${*}"

  return 0
}

#######################################
# Show app task level debugging information
#
# Arguments:
#   $@: messages
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_info() {
  [[ "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_ALL" && "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_APP_TASK" && "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_APP_ALL" || "$#" == '0' ]] &&
    return 0
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${*}"

  return 0
}

#######################################
# Show bashlib64 task level variable values
#
# Arguments:
#   $@: variable names
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_show_vars() {
  local variable=''

  [[ "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_ALL" && "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_LIB_TASK" && "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_LIB_ALL" || "$#" == '0' ]] &&
    return 0

  for variable in "$@"; do
    eval "_bl64_dbg_show \"[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_SHELL_VAR}: [${variable}=\$${variable}]\""
  done

  return 0
}

#######################################
# Show app task level variable values
#
# Arguments:
#   $@: variable names
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
function bl64_dbg_app_show_vars() {
  local variable=''

  [[ "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_ALL" && "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_APP_TASK" && "$BL64_DBG_TARGET" != "$BL64_DBG_TARGET_APP_ALL" || "$#" == '0' ]] &&
    return 0

  for variable in "$@"; do
    eval "_bl64_dbg_show \"[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_SHELL_VAR}: [${variable}=\$${variable}]\""
  done

  return 0
}

#######################################
# Show bashlib64 function name and parameters
#
# Arguments:
#   $@: parameters
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
# shellcheck disable=SC2120
function bl64_dbg_lib_show_function() {
  bl64_dbg_lib_task_enabled || return 0

  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_LIB_RUN}: [${*}]"
  return 0
}

#######################################
# Show app function name and parameters
#
# Arguments:
#   $@: parameters
# Outputs:
#   STDOUT: None
#   STDERR: Debug message
# Returns:
#   0: always ok
#######################################
# shellcheck disable=SC2120
function bl64_dbg_app_show_function() {
  bl64_dbg_app_task_enabled || return 0

  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_APP_RUN}: [${*}]"
  return 0
}

#######################################
# BashLib64 / Module / Setup / Manage local filesystem
#
# Version: 1.4.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_fs_setup() {
  bl64_dbg_lib_show_function

  bl64_fs_set_command &&
    bl64_fs_set_alias &&
    bl64_fs_set_options &&
    BL64_FS_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function bl64_fs_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_FS_CMD_CHMOD='/bin/chmod'
    BL64_FS_CMD_CHOWN='/bin/chown'
    BL64_FS_CMD_CP='/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/bin/ln'
    BL64_FS_CMD_LS='/bin/ls'
    BL64_FS_CMD_MKDIR='/bin/mkdir'
    BL64_FS_CMD_MKTEMP='/bin/mktemp'
    BL64_FS_CMD_MV='/bin/mv'
    BL64_FS_CMD_RM='/bin/rm'
    BL64_FS_CMD_TOUCH='/usr/bin/touch'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_FS_CMD_CHMOD='/usr/bin/chmod'
    BL64_FS_CMD_CHOWN='/usr/bin/chown'
    BL64_FS_CMD_CP='/usr/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/bin/ln'
    BL64_FS_CMD_LS='/usr/bin/ls'
    BL64_FS_CMD_MKDIR='/usr/bin/mkdir'
    BL64_FS_CMD_MKTEMP='/usr/bin/mktemp'
    BL64_FS_CMD_MV='/usr/bin/mv'
    BL64_FS_CMD_RM='/usr/bin/rm'
    BL64_FS_CMD_TOUCH='/usr/bin/touch'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_FS_CMD_CHMOD='/bin/chmod'
    BL64_FS_CMD_CHOWN='/bin/chown'
    BL64_FS_CMD_CP='/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/bin/ln'
    BL64_FS_CMD_LS='/bin/ls'
    BL64_FS_CMD_MKDIR='/bin/mkdir'
    BL64_FS_CMD_MKTEMP='/bin/mktemp'
    BL64_FS_CMD_MV='/bin/mv'
    BL64_FS_CMD_RM='/bin/rm'
    BL64_FS_CMD_TOUCH='/bin/touch'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_FS_CMD_CHMOD='/bin/chmod'
    BL64_FS_CMD_CHOWN='/usr/sbin/chown'
    BL64_FS_CMD_CP='/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/bin/ln'
    BL64_FS_CMD_LS='/bin/ls'
    BL64_FS_CMD_MKDIR='/bin/mkdir'
    BL64_FS_CMD_MKTEMP='/usr/bin/mktemp'
    BL64_FS_CMD_MV='/bin/mv'
    BL64_FS_CMD_RM='/bin/rm'
    BL64_FS_CMD_TOUCH='/usr/bin/touch'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_fs_set_options() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_FS_SET_MKDIR_VERBOSE='--verbose'
    BL64_FS_SET_MKDIR_PARENTS='--parents'
    BL64_FS_SET_CHOWN_VERBOSE='--verbose'
    BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
    BL64_FS_SET_CP_VERBOSE='--verbose'
    BL64_FS_SET_CP_RECURSIVE='--recursive'
    BL64_FS_SET_CP_FORCE='--force'
    BL64_FS_SET_CHMOD_VERBOSE='--verbose'
    BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
    BL64_FS_SET_LN_SYMBOLIC='--symbolic'
    BL64_FS_SET_LN_VERBOSE='--verbose'
    BL64_FS_SET_MV_VERBOSE='--verbose'
    BL64_FS_SET_MV_FORCE='--force'
    BL64_FS_SET_RM_VERBOSE='--verbose'
    BL64_FS_SET_RM_FORCE='--force'
    BL64_FS_SET_RM_RECURSIVE='--recursive'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_FS_SET_MKDIR_VERBOSE=' '
    BL64_FS_SET_MKDIR_PARENTS='-p'
    BL64_FS_SET_CHOWN_VERBOSE='-v'
    BL64_FS_SET_CHOWN_RECURSIVE='-R'
    BL64_FS_SET_CP_VERBOSE='-v'
    BL64_FS_SET_CP_RECURSIVE='-R'
    BL64_FS_SET_CP_FORCE='-f'
    BL64_FS_SET_CHMOD_VERBOSE='-v'
    BL64_FS_SET_CHMOD_RECURSIVE='-R'
    BL64_FS_SET_LN_SYMBOLIC='-s'
    BL64_FS_SET_LN_VERBOSE='-v'
    BL64_FS_SET_MV_VERBOSE=' '
    BL64_FS_SET_MV_FORCE='-f'
    BL64_FS_SET_RM_VERBOSE=' '
    BL64_FS_SET_RM_FORCE='-f'
    BL64_FS_SET_RM_RECURSIVE='-R'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_FS_SET_MKDIR_VERBOSE='-v'
    BL64_FS_SET_MKDIR_PARENTS='-p'
    BL64_FS_SET_CHOWN_VERBOSE='-v'
    BL64_FS_SET_CHOWN_RECURSIVE='-R'
    BL64_FS_SET_CP_VERBOSE='-v'
    BL64_FS_SET_CP_RECURSIVE='-R'
    BL64_FS_SET_CP_FORCE='-f'
    BL64_FS_SET_CHMOD_VERBOSE='-v'
    BL64_FS_SET_CHMOD_RECURSIVE='-R'
    BL64_FS_SET_LN_SYMBOLIC='-s'
    BL64_FS_SET_LN_VERBOSE='-v'
    BL64_FS_SET_MV_VERBOSE='-v'
    BL64_FS_SET_MV_FORCE='-f'
    BL64_FS_SET_RM_VERBOSE='-v'
    BL64_FS_SET_RM_FORCE='-f'
    BL64_FS_SET_RM_RECURSIVE='-R'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
# shellcheck disable=SC2034
function bl64_fs_set_alias() {
  local cmd_mawk='/usr/bin/mawk'

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_FS_ALIAS_LS_FILES="${BL64_FS_CMD_LS} --color=never"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_FS_ALIAS_LS_FILES="${BL64_FS_CMD_LS} --color=never"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_FS_ALIAS_LS_FILES="${BL64_FS_CMD_LS} --color=never"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac

  BL64_FS_ALIAS_CHOWN_DIR="${BL64_FS_CMD_CHOWN} ${BL64_FS_SET_CHOWN_VERBOSE} ${BL64_FS_SET_CHOWN_RECURSIVE}"
  BL64_FS_ALIAS_CP_DFIND="/usr/bin/find"
  BL64_FS_ALIAS_CP_DIR="${BL64_FS_CMD_CP} ${BL64_FS_SET_CP_VERBOSE} ${BL64_FS_SET_CP_FORCE} ${BL64_FS_SET_CP_RECURSIVE}"
  BL64_FS_ALIAS_CP_FIFIND="/usr/bin/find"
  BL64_FS_ALIAS_CP_FILE="${BL64_FS_CMD_CP} ${BL64_FS_SET_CP_VERBOSE} ${BL64_FS_SET_CP_FORCE}"
  BL64_FS_ALIAS_LN_SYMBOLIC="${BL64_FS_CMD_LN} ${BL64_FS_SET_LN_SYMBOLIC} ${BL64_FS_SET_LN_VERBOSE}"
  BL64_FS_ALIAS_MKDIR_FULL="${BL64_FS_CMD_MKDIR} ${BL64_FS_SET_MKDIR_VERBOSE} ${BL64_FS_SET_MKDIR_PARENTS}"
  BL64_FS_ALIAS_MKTEMP_DIR="${BL64_FS_CMD_MKTEMP} -d"
  BL64_FS_ALIAS_MKTEMP_FILE="${BL64_FS_CMD_MKTEMP}"
  BL64_FS_ALIAS_MV="${BL64_FS_CMD_MV} ${BL64_FS_SET_MV_VERBOSE} ${BL64_FS_SET_MV_FORCE}"
  BL64_FS_ALIAS_MV="${BL64_FS_CMD_MV} ${BL64_FS_SET_MV_VERBOSE} ${BL64_FS_SET_MV_FORCE}"
  BL64_FS_ALIAS_RM_FILE="${BL64_FS_CMD_RM} ${BL64_FS_SET_RM_VERBOSE} ${BL64_FS_SET_RM_FORCE}"
  BL64_FS_ALIAS_RM_FULL="${BL64_FS_CMD_RM} ${BL64_FS_SET_RM_VERBOSE} ${BL64_FS_SET_RM_FORCE} ${BL64_FS_SET_RM_RECURSIVE}"
}

#######################################
# BashLib64 / Module / Functions / Manage local filesystem
#
# Version: 2.3.1
#######################################

#######################################
# Create one ore more directories, then set owner and permissions
#
#  Features:
#   * If the new path is already present nothing is done. No error or warning is presented
# Limitations:
#   * Parent directories are not created
#   * No rollback in case of errors. The process will not remove already created paths
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $@: full directory paths
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_create_dir() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_LIB_DEFAULT}}"
  local user="${2:-${BL64_LIB_DEFAULT}}"
  local group="${3:-${BL64_LIB_DEFAULT}}"
  local path=''

  # Remove consumed parameters
  shift
  shift
  shift

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "path list:[${*}]"

  for path in "$@"; do

    bl64_check_path_absolute "$path" || return $?
    [[ -d "$path" ]] && continue

    bl64_fs_run_mkdir "$path" &&
      bl64_fs_set_permissions "$path" "$mode" "$user" "$group" ||
      return $?

  done

  return 0
}

#######################################
# Copy one ore more files to a single destination, then set owner and permissions
#
# Requirements:
#   * Destination path should be present
#   * root privilege (sudo) if paths are restricted or change owner is requested
# Limitations:
#   * No rollback in case of errors. The process will not remove already copied files
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $4: destination path
#   $@: full file paths
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_copy_files() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_LIB_DEFAULT}}"
  local user="${2:-${BL64_LIB_DEFAULT}}"
  local group="${3:-${BL64_LIB_DEFAULT}}"
  local destination="${4:-${BL64_LIB_DEFAULT}}"
  local path=''
  local target=''

  bl64_check_directory "$destination" || return $?

  # Remove consumed parameters
  bl64_dbg_lib_show_info "source files:[${*}]"
  shift
  shift
  shift
  shift

  # shellcheck disable=SC2086
  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "paths:[${*}]"
  for path in "$@"; do

    target=''
    bl64_check_path_absolute "$path" &&
      target="${destination}/$(bl64_fmt_basename "$path")" &&
      bl64_fs_cp_file "$path" "$target" &&
      bl64_fs_set_permissions "$target" "$mode" "$user" "$group" ||
      return $?
  done

  return 0
}

#######################################
# Merge 2 or more files into a new one, then set owner and permissions
#
# * If the destination is already present no update is done unless requested
# * If asked to replace destination, temporary backup is done in case git fails by moving the destination to a temp name
#
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $4: replace existing content. Values: $BL64_LIB_VAR_ON | $BL64_LIB_VAR_OFF (default)
#   $5: destination file. Full path
#   $@: source files. Full path
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#   $BL64_FS_ERROR_EXISTING_FILE
#   $BL64_LIB_ERROR_TASK_FAILED
#######################################
function bl64_fs_merge_files() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_LIB_DEFAULT}}"
  local user="${2:-${BL64_LIB_DEFAULT}}"
  local group="${3:-${BL64_LIB_DEFAULT}}"
  local replace="${4:-${BL64_LIB_DEFAULT}}"
  local destination="${5:-${BL64_LIB_DEFAULT}}"
  local path=''
  local -i status=0

  bl64_check_parameter 'destination' || return $?
  bl64_check_overwrite "$destination" "$replace" || return $?

  # Remove consumed parameters
  shift
  shift
  shift
  shift
  shift
  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "source files:[${*}]"

  # Asked to replace, backup first
  bl64_fs_safeguard "$destination" || return $?

  for path in "$@"; do
    bl64_dbg_lib_show_info "concatenate file (${path})"
    bl64_check_path_absolute "$path" &&
      "$BL64_OS_CMD_CAT" "$path"
    status=$?
    ((status != 0)) && break
    :
  done >>"$destination"

  if [[ "$status" == '0' ]]; then
    bl64_fs_set_permissions "$destination" "$mode" "$user" "$group"
    status=$?
  fi

  # Rollback if error
  bl64_fs_restore "$destination" "$status" || return $?
  return $status
}

#######################################
# Merge contents from source directory to target
#
# Requirements:
#   * root privilege (sudo) if the files are restricted
# Arguments:
#   $1: source path
#   $2: target path
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   bl64_check_parameter
#   bl64_check_directory
#   command exit status
#######################################
function bl64_fs_merge_dir() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-${BL64_LIB_DEFAULT}}"
  local target="${2:-${BL64_LIB_DEFAULT}}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' &&
    bl64_check_directory "$source" &&
    bl64_check_directory "$target" ||
    return $?

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    bl64_fs_cp_dir --no-target-directory "$source" "$target"
    ;;
  ${BL64_OS_MCOS}-*)
    # shellcheck disable=SC2086
    bl64_fs_cp_dir ${source}/ "$target"
    ;;
  ${BL64_OS_ALP}-*)
    # shellcheck disable=SC2086
    shopt -sq dotglob &&
      bl64_fs_cp_dir ${source}/* -t "$target" &&
      shopt -uq dotglob
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_run_chown() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose=''

  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_CHOWN_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CHOWN" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_run_chmod() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose=''

  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_CHMOD_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CHMOD" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Change directory ownership recursively
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_chown_dir() {
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  bl64_fs_run_chown "$BL64_FS_SET_CHOWN_RECURSIVE" "$@"
}

#######################################
# Copy files with force flag
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_cp_file() {
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$@"
}

#######################################
# Copy directory with recursive and force flags
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_cp_dir() {
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  bl64_fs_run_cp "$BL64_FS_SET_CP_FORCE" "$BL64_FS_SET_CP_RECURSIVE" "$@"
}

#######################################
# Create a symbolic link
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_ln_symbolic() {
  bl64_dbg_lib_show_function "$@"

  bl64_fs_run_ln "$BL64_FS_SET_LN_SYMBOLIC" "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_run_mkdir() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose=''

  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_MKDIR_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MKDIR" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Create full path including parents
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_mkdir_full() {
  bl64_dbg_lib_show_function "$@"

  bl64_fs_run_mkdir "$BL64_FS_SET_MKDIR_PARENTS" "$@"
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_run_mv() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose=''

  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_MV_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_MV" $verbose "$BL64_FS_SET_MV_FORCE" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove files using the verbose and force flags. Limited to current filesystem
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_rm_file() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_RM_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_FS_CMD_RM" $verbose "$BL64_FS_SET_RM_FORCE" "$@"
}

#######################################
# Remove directories using the verbose and force flags. Limited to current filesystem
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_rm_full() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_RM_VERBOSE"

  # shellcheck disable=SC2086
  "$BL64_FS_CMD_RM" $verbose "$BL64_FS_SET_RM_FORCE" "$BL64_FS_SET_RM_RECURSIVE" "$@"
}

#######################################
# Remove content from OS temporary repositories
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_tmps() {
  bl64_dbg_lib_show_function
  bl64_fs_rm_full -- /tmp/[[:alnum:]]*
  bl64_fs_rm_full -- /var/tmp/[[:alnum:]]*
  return 0
}

#######################################
# Remove or reset logs from standard locations
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_logs() {
  bl64_dbg_lib_show_function
  local target='/var/log'

  if [[ -d "$target" ]]; then
    bl64_fs_rm_full ${target}/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Remove or reset OS caches from standard locations
#
# Arguments:
#   None
# Outputs:
#   STDOUT: rm output
#   STDERR: rm stderr
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_caches() {
  bl64_dbg_lib_show_function
  local target='/var/cache/man'

  if [[ -d "$target" ]]; then
    bl64_fs_rm_full ${target}/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Performs a complete cleanup of the OS temporary content
#
# * Removes temporary files
# * Cleans caches
# * Removes logs
#
# Arguments:
#   None
# Outputs:
#   STDOUT: output from clean functions
#   STDERR: output from clean functions
# Returns:
#   0: always ok
#######################################
function bl64_fs_cleanup_full() {
  bl64_dbg_lib_show_function

  bl64_pkg_cleanup
  bl64_fs_cleanup_tmps
  bl64_fs_cleanup_logs
  bl64_fs_cleanup_caches

  return 0
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_run_find() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
  bl64_check_command "$BL64_FS_CMD_FIND" || return $?

  bl64_dbg_lib_trace_start
  "$BL64_FS_CMD_FIND" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Find files and report as list
#
# * Not using bl64_fs_find to avoid file expansion for -name
#
# Arguments:
#   $1: search path
#   $2: search pattern. Format: find -name options
#   $3: search content in text files
# Outputs:
#   STDOUT: file list. One path per line
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_find_files() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-.}"
  local pattern="${2:-${BL64_LIB_DEFAULT}}"
  local content="${3:-${BL64_LIB_DEFAULT}}"

  bl64_check_command "$BL64_FS_CMD_FIND" &&
    bl64_check_directory "$path" || return $?

  [[ "$pattern" == "$BL64_LIB_DEFAULT" ]] && pattern=''

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  if [[ "$content" == "$BL64_LIB_DEFAULT" ]]; then
    "$BL64_FS_CMD_FIND" \
      "$path" \
      -type 'f' \
      ${pattern:+-name "${pattern}"} \
      -print
  else
    "$BL64_FS_CMD_FIND" \
      "$path" \
      -type 'f' \
      ${pattern:+-name "${pattern}"} \
      -exec \
        "$BL64_TXT_CMD_GREP" \
        "$BL64_TXT_SET_GREP_SHOW_FILE_ONLY" \
        "$BL64_TXT_SET_GREP_ERE" "$content" \
        "{}" \;
  fi
  bl64_dbg_lib_trace_stop

}

#######################################
# Safeguard path to a temporary location
#
# * Use for file/dir operations that will alter or replace the content and requires a quick rollback mechanism
# * The original path is renamed until bl64_fs_restore is called to either remove or restore it
# * If the destination is not present nothing is done. Return with no error. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_safeguard)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_safeguard() {
  bl64_dbg_lib_show_function "$@"
  local destination="${1:-}"
  local backup="${destination}${BL64_FS_SAFEGUARD_POSTFIX}"

  bl64_check_parameter 'destination' ||
    return $?

  # Return if not present
  if [[ ! -e "$destination" ]]; then
    bl64_dbg_lib_show_info "path is not yet created, nothing to do (${destination})"
    return 0
  fi

  bl64_dbg_lib_show_info "safeguard object: [${destination}]->[${backup}]"
  if ! bl64_fs_run_mv "$destination" "$backup"; then
    bl64_msg_show_error "$_BL64_FS_TXT_SAFEGUARD_FAILED ($destination)"
    return $BL64_LIB_ERROR_TASK_BACKUP
  fi

  return 0
}

#######################################
# Restore path from safeguard if operation failed or remove if operation was ok
#
# * Use as a quick rollback for file/dir operations
# * Called after bl64_fs_safeguard creates the backup
# * If the backup is not there nothing is done, no error returned. This is to cover for first time path creation
#
# Arguments:
#   $1: safeguard path (produced by bl64_fs_safeguard)
#   $2: task status (exit status from last operation)
# Outputs:
#   STDOUT: command dependant
#   STDERR: command dependant
# Returns:
#   command dependant
#######################################
function bl64_fs_restore() {
  bl64_dbg_lib_show_function "$@"
  local destination="${1:-}"
  local result="${2:-}"
  local backup="${destination}${BL64_FS_SAFEGUARD_POSTFIX}"

  bl64_check_parameter 'destination' &&
    bl64_check_parameter 'result' ||
    return $?

  # Return if not present
  if [[ ! -e "$backup" ]]; then
    bl64_dbg_lib_show_info "backup was not created, nothing to do (${backup})"
    return 0
  fi

  # Check if restore is needed based on the operation result
  if [[ "$result" == "$BL64_LIB_VAR_OK" ]]; then
    bl64_dbg_lib_show_info 'operation was ok, backup no longer needed, remove it'
    [[ -e "$backup" ]] && bl64_fs_rm_full "$backup"

    # shellcheck disable=SC2086
    return $BL64_LIB_VAR_OK
  else
    bl64_dbg_lib_show_info 'operation was NOT ok, remove invalid content'
    [[ -e "$destination" ]] && bl64_fs_rm_full "$destination"

    bl64_dbg_lib_show_info 'restore content from backup'
    # shellcheck disable=SC2086
    bl64_fs_run_mv "$backup" "$destination" ||
      return $BL64_LIB_ERROR_TASK_RESTORE
  fi
}

#######################################
# Set object permissions and ownership
#
# Arguments:
#   $1: object path
#   $2: permissions. Format: chown format. Default: use current umask
#   $3: user name. Default: nonde
#   $4: group name. Default: current
# Outputs:
#   STDOUT: command stdin
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_set_permissions() {
  bl64_dbg_lib_show_function "$@"
  local path="${1:-}"
  local mode="${2:-${BL64_LIB_DEFAULT}}"
  local user="${3:-${BL64_LIB_DEFAULT}}"
  local group="${4:-${BL64_LIB_DEFAULT}}"

  bl64_check_parameter 'path' &&
    bl64_check_path "$path" ||
    return $?

  # Determine if mode needs to be set
  if [[ "$mode" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_fs_run_chmod "$mode" "$path" || return $?
  fi

  # Determine if owner needs to be set
  if [[ "$user" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_fs_run_chown "${user}" "$path" || return $?
  fi

  # Determine if group needs to be set
  if [[ "$group" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_fs_run_chown ":${group}" "$path" || return $?
  fi

  return 0
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_run_cp() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose=''

  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_CP_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_CP" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_run_ls() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?

  bl64_dbg_lib_trace_start
  "$BL64_FS_CMD_LS" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_run_ln() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose=''

  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_LN_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_LN" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Set default path creation permission with umask
#
# * Uses symbolic permission form
# * Supports predefined sets: BL64_FS_UMASK_*
#
# Arguments:
#   $1: permission. Format: BL64_FS_UMASK_RW_USER
# Outputs:
#   STDOUT: None
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
# shellcheck disable=SC2120
function bl64_fs_set_umask() {
  bl64_dbg_lib_show_function "$@"
  local permissions="${1:-${BL64_FS_UMASK_RW_USER}}"

  umask -S "$permissions" >/dev/null
}

#######################################
# Set global ephemeral paths for bashlib64 functions
#
# * When set, bashlib64 can use these locations as alternative paths to standard ephemeral locations (tmp, cache, etc)
# * Path is created if not already present
#
# Arguments:
#   $1: Temporal files. Short lived, data should be removed after usage. Format: full path
#   $2: cache files. Lifecycle managed by the consumer. Data can persist between runs. If data is removed, consumer should be able to regenerate it. Format: full path
#   $3: permissions. Format: chown format. Default: use current umask
#   $4: user name. Default: current
#   $5: group name. Default: current
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_set_ephemeral() {
  bl64_dbg_lib_show_function "$@"
  local temporal="${1:-${BL64_LIB_DEFAULT}}"
  local cache="${2:-${BL64_LIB_DEFAULT}}"
  local mode="${3:-${BL64_LIB_DEFAULT}}"
  local user="${4:-${BL64_LIB_DEFAULT}}"
  local group="${5:-${BL64_LIB_DEFAULT}}"

  if [[ "$temporal" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_fs_create_dir "$mode" "$user" "$group" "$temporal" &&
      BL64_FS_PATH_TEMPORAL="$temporal" ||
      return $?
  fi

  if [[ "$cache" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_fs_create_dir "$mode" "$user" "$group" "$cache" &&
      BL64_FS_PATH_CACHE="$cache" ||
      return $?
  fi

  return 0
}

#######################################
# BashLib64 / Module / Functions / Format text data
#
# Version: 1.4.0
#######################################

#######################################
# Removes comments from text input using the external tool Grep
#
# * Comment delimiter: #
# * All text to the right of the delimiter is removed
#
# Arguments:
#   $1: Full path to the text file. Default: STDIN
# Outputs:
#   STDOUT: Original text with comments removed
#   STDERR: grep Error message
# Returns:
#   0: successfull execution
#   >0: grep command exit status
#######################################
function bl64_fmt_strip_comments() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:--}"

  "$BL64_TXT_CMD_GREP" "$BL64_TXT_SET_GREP_INVERT" "$BL64_TXT_SET_GREP_ERE" '^#.*$|^ *#.*$' "$source"
}

#######################################
# Removes starting slash from path
#
# * If path is a single slash or relative path no change is done
#
# Arguments:
#   $1: Target path
# Outputs:
#   STDOUT: Updated path
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_strip_starting_slash() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return $BL64_LIB_VAR_OK
  elif [[ "$path" == '/' ]]; then
    printf '%s' "${path}"
  elif [[ "$path" == /* ]]; then
    printf '%s' "${path:1}"
  else
    printf '%s' "${path}"
  fi
}

#######################################
# Removes ending slash from path
#
# * If path is a single slash or no ending slash is present no change is done
#
# Arguments:
#   $1: Target path
# Outputs:
#   STDOUT: Updated path
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_strip_ending_slash() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return $BL64_LIB_VAR_OK
  elif [[ "$path" == '/' ]]; then
    printf '%s' "${path}"
  elif [[ "$path" == */ ]]; then
    printf '%s' "${path:0:-1}"
  else
    printf '%s' "${path}"
  fi
}

#######################################
# Show the last part (basename) of a path
#
# * The function operates on text data, it doesn't verify path existance
# * The last part can be either a directory or a file
# * Parts are separated by the / character
# * The basename is defined by taking the text to the right of the last separator
# * Function mimics the linux basename command
#
# Examples:
#
#   bl64_fmt_basename '/full/path/to/file' -> 'file'
#   bl64_fmt_basename '/full/path/to/file/' -> ''
#   bl64_fmt_basename 'path/to/file' -> 'file'
#   bl64_fmt_basename 'path/to/file/' -> ''
#   bl64_fmt_basename '/file' -> 'file'
#   bl64_fmt_basename '/' -> ''
#   bl64_fmt_basename 'file' -> 'file'
#
# Arguments:
#   $1: Path
# Outputs:
#   STDOUT: Basename
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_basename() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"
  local base=''

  if [[ -n "$path" && "$path" != '/' ]]; then
    base="${path##*/}"
  fi

  if [[ -z "$base" || "$base" == */* ]]; then
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_PARAMETER_INVALID
  else
    printf '%s' "$base"
  fi
  return 0
}

#######################################
# Show the directory part of a path
#
# * The function operates on text data, it doesn't verify path existance
# * Parts are separated by the slash (/) character
# * The directory is defined by taking the input string up to the last separator
#
# Examples:
#
#   bl64_fmt_dirname '/full/path/to/file' -> '/full/path/to'
#   bl64_fmt_dirname '/full/path/to/file/' -> '/full/path/to/file'
#   bl64_fmt_dirname '/file' -> '/'
#   bl64_fmt_dirname '/' -> '/'
#   bl64_fmt_dirname 'dir' -> 'dir'
#
# Arguments:
#   $1: Path
# Outputs:
#   STDOUT: Dirname
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_fmt_dirname() {
  bl64_dbg_lib_show_function "$@"
  local path="$1"

  # shellcheck disable=SC2086
  if [[ -z "$path" ]]; then
    return $BL64_LIB_VAR_OK
  elif [[ "$path" == '/' ]]; then
    printf '%s' "${path}"
  elif [[ "$path" != */* ]]; then
    printf '%s' "${path}"
  elif [[ "$path" == /*/* ]]; then
    printf '%s' "${path%/*}"
  elif [[ "$path" == */*/* ]]; then
    printf '%s' "${path%/*}"
  elif [[ "$path" == /* && "${path:1}" != */* ]]; then
    printf '%s' '/'
  fi
}

#######################################
# Convert list to string. Optionally add prefix, postfix to each field
#
# * list: lines separated by \n
# * string: same as original list but with \n replaced with space
#
# Arguments:
#   $1: output field separator. Default: space
#   $2: prefix. Format: string
#   $3: postfix. Format: string
# Inputs:
#   STDIN: list
# Outputs:
#   STDOUT: string
#   STDERR: None
# Returns:
#   always ok
#######################################
function bl64_fmt_list_to_string() {
  bl64_dbg_lib_show_function
  local field_separator="${1:-${BL64_LIB_DEFAULT}}"
  local prefix="${2:-${BL64_LIB_DEFAULT}}"
  local postfix="${3:-${BL64_LIB_DEFAULT}}"

  [[ "$field_separator" == "$BL64_LIB_DEFAULT" ]] && field_separator=' '
  [[ "$prefix" == "$BL64_LIB_DEFAULT" ]] && prefix=''
  [[ "$postfix" == "$BL64_LIB_DEFAULT" ]] && postfix=''

  bl64_txt_run_awk \
    -v field_separator="$field_separator" \
    -v prefix="$prefix" \
    -v postfix="$postfix" \
    '
    BEGIN {
      joined_string = ""
      RS="\n"
    }
    {
      joined_string = ( joined_string == "" ? "" : joined_string field_separator ) prefix $0 postfix
    }
    END { print joined_string }
  '
}

#######################################
# Build a separator line with optional payload
#
# * Separator format: payload + \n
#
# Arguments:
#   $1: Separator payload. Format: string
# Outputs:
#   STDOUT: separator line
#   STDERR: grep Error message
# Returns:
#   printf exit status
#######################################
function bl64_fmt_separator_line() {
  bl64_dbg_lib_show_function "$@"
  local payload="${1:-}"

  printf '%s\n' "$payload"
}

#######################################
# BashLib64 / Module / Setup / Manage OS identity and access service
#
# Version: 1.3.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_iam_setup() {
  bl64_dbg_lib_show_function

  bl64_iam_set_command &&
    bl64_iam_set_alias &&
    bl64_iam_set_options &&
    BL64_IAM_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_iam_set_command() {
  bl64_dbg_lib_show_function

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_IAM_CMD_USERADD='/usr/sbin/useradd'
    BL64_IAM_CMD_ID='/usr/bin/id'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_IAM_CMD_USERADD='/usr/sbin/adduser'
    BL64_IAM_CMD_ID='/usr/bin/id'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_IAM_CMD_USERADD='/usr/bin/dscl'
    BL64_IAM_CMD_ID='/usr/bin/id'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_iam_set_alias() {
  bl64_dbg_lib_show_function

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_IAM_ALIAS_USERADD="$BL64_IAM_CMD_USERADD -q . -create"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_iam_set_options() {
  bl64_dbg_lib_show_function

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_IAM_SET_USERADD_CREATE_HOME='--create-home'
    BL64_IAM_SET_USERADD_HOME_PATH='--home-dir'
    ;;
  ${BL64_OS_ALP}-*)
    # Home is created by default
    BL64_IAM_SET_USERADD_CREATE_HOME=' '
    BL64_IAM_SET_USERADD_HOME_PATH='-h'
    ;;
  ${BL64_OS_MCOS}-*)
    # Home is created by default
    BL64_IAM_SET_USERADD_CREATE_HOME=' '
    BL64_IAM_SET_USERADD_HOME_PATH=' '
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Manage OS identity and access service
#
# Version: 1.8.0
#######################################

#######################################
# Create OS user
#
# * If the user is already created nothing is done, no error
#
# Arguments:
#   $1: login name
#   $2: home. Default: os native
# Outputs:
#   STDOUT: native user add command output
#   STDERR: native user add command error messages
# Returns:
#   native user add command error status
#######################################
function bl64_iam_user_add() {
  bl64_dbg_lib_show_function "$@"
  local login="${1:-}"
  local home="${2:-}"

  bl64_check_privilege_root &&
    bl64_check_parameter 'login' ||
    return $?

  if bl64_iam_user_is_created "$login"; then
    bl64_dbg_lib_show_info "user already created, nothing to do ($login)"
    return 0
  fi

  bl64_msg_show_lib_task "$_BL64_IAM_TXT_ADD_USER ($login)"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    "$BL64_IAM_CMD_USERADD" \
      $BL64_IAM_SET_USERADD_CREATE_HOME \
      ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
      "$login"
    ;;
  ${BL64_OS_ALP}-*)
    "$BL64_IAM_CMD_USERADD" \
      $BL64_IAM_SET_USERADD_CREATE_HOME \
      ${home:+${BL64_IAM_SET_USERADD_HOME_PATH} "${home}"} \
      -D \
      "$login"
    ;;
  ${BL64_OS_MCOS}-*)
    "$BL64_IAM_CMD_USERADD" \
      $BL64_IAM_SET_USERADD_CREATE_HOME \
      -q . \
      -create "/Users/${login}"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Determine if the user is created
#
# Arguments:
#   $1: login name
# Outputs:
#   STDOUT: native user add command output
#   STDERR: native user add command error messages
# Returns:
#   native user add command error status
#######################################
function bl64_iam_user_is_created() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"

  bl64_check_parameter 'user' ||
    return $?

  # Use the ID command to detect if the user is created
  bl64_iam_user_get_id "$user" > /dev/null 2>&1

}

#######################################
# Get user's UID
#
# Arguments:
#   $1: user login name. Default: current user
# Outputs:
#   STDOUT: user ID
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_iam_user_get_id() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"

  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    "${BL64_IAM_CMD_ID}" -u $user
    ;;
  ${BL64_OS_ALP}-*)
    "${BL64_IAM_CMD_ID}" -u $user
    ;;
  ${BL64_OS_MCOS}-*)
    "${BL64_IAM_CMD_ID}" -u $user
    ;;
  *) bl64_check_alert_unsupported ;;
  esac

}

#######################################
# Get current user name
#
# Arguments:
#   None
# Outputs:
#   STDOUT: user name
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_iam_user_get_current() {
  bl64_dbg_lib_show_function
  "${BL64_IAM_CMD_ID}" -u -n
}

#######################################
# BashLib64 / Module / Setup / Write messages to logs
#
# Version: 2.0.0
#######################################

#######################################
# Setup the bashlib64 module
#
# Arguments:
#   $1: log repository. Full path
#   $2: log target. Default: BL64_SCRIPT_ID
#   $2: level. One of BL64_LOG_CATEGORY_*
#   $3: format. One of BL64_LOG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function bl64_log_setup() {
  bl64_dbg_lib_show_function "$@"
  local repository="${1:-}"
  local target="${2:-${BL64_SCRIPT_ID}}"
  local level="${3:-${BL64_LOG_CATEGORY_NONE}}"
  local format="${4:-${BL64_LOG_FORMAT_CSV}}"

  [[ -z "$repository" ]] && return $BL64_LIB_ERROR_PARAMETER_MISSING

  bl64_log_set_repository "$repository" &&
    bl64_log_set_target "$target" &&
    bl64_log_set_level "$level" &&
    bl64_log_set_format "$format" ||
    return $?

  BL64_LOG_MODULE="$BL64_LIB_VAR_ON"
}

#######################################
# Set log repository
#
# * Create the repository directory
#
# Arguments:
#   $1: repository path
# Outputs:
#   STDOUT: None
#   STDERR: command stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_repository() {
  bl64_dbg_lib_show_function "$@"
  local repository="$1"

  if [[ ! -d "$repository" ]]; then
    "$BL64_FS_CMD_MKDIR" "$repository" &&
      "$BL64_FS_CMD_CHMOD" "$BL64_LOG_REPOSITORY_MODE" "$repository" ||
      return $BL64_LIB_ERROR_TASK_FAILED
  else
    [[ -w "$repository" ]] || return $BL64_LIB_ERROR_TASK_FAILED
  fi

  BL64_LOG_REPOSITORY="$repository"
  return 0
}

#######################################
# Set logging level
#
# Arguments:
#   $1: target level. One of BL64_LOG_CATEGORY_*
# Outputs:
#   STDOUT: None
#   STDERR: check error
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_level() {
  bl64_dbg_lib_show_function "$@"
  local level="$1"

  case "$level" in
  "$BL64_LOG_CATEGORY_NONE") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_NONE" ;;
  "$BL64_LOG_CATEGORY_INFO") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_INFO" ;;
  "$BL64_LOG_CATEGORY_DEBUG") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_DEBUG" ;;
  "$BL64_LOG_CATEGORY_WARNING") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_WARNING" ;;
  "$BL64_LOG_CATEGORY_ERROR") BL64_LOG_LEVEL="$BL64_LOG_CATEGORY_ERROR" ;;
  *) return $BL64_LIB_ERROR_PARAMETER_INVALID ;;
  esac
}

#######################################
# Set log format
#
# Arguments:
#   $1: log format. One of BL64_LOG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: commands stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_format() {
  bl64_dbg_lib_show_function "$@"
  local format="$1"

  case "$format" in
  "$BL64_LOG_FORMAT_CSV")
    BL64_LOG_FORMAT="$BL64_LOG_FORMAT_CSV"
    BL64_LOG_FS=':'
    ;;
  *) return $BL64_LIB_ERROR_PARAMETER_INVALID ;;
  esac
}

#######################################
# Set log target
#
# * Log target is the file where logs will be written to
# * File is created or appended in the log repository
#
# Arguments:
#   $1: log target. Format: file name
# Outputs:
#   STDOUT: None
#   STDERR: commands stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_target() {
  bl64_dbg_lib_show_function "$@"
  local target="$1"
  local destination="${BL64_LOG_REPOSITORY}/${target}"

  # Check if there is a new target to set
  [[ "$BL64_LOG_DESTINATION" == "$destination" ]] && return 0

  if [[ ! -w "$destination" ]]; then
    "$BL64_FS_CMD_TOUCH" "$destination" &&
      "$BL64_FS_CMD_CHMOD" "$BL64_LOG_TARGET_MODE" "$destination" ||
      return $BL64_LIB_ERROR_TASK_FAILED
  fi

  BL64_LOG_DESTINATION="$destination"
  return 0
}

#######################################
# Set runtime log target
#
# * Use to save output from commands using one file per execution
# * The target name is used as the directory for each execution
# * The target directory is created in the log repository
# * The calling script is responsible for redirecting the command's output to the target path BL64_LOG_RUNTIME
#
# Arguments:
#   $1: runtime log target. Format: directory name
# Outputs:
#   STDOUT: None
#   STDERR: commands stderr
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_log_set_runtime() {
  bl64_dbg_lib_show_function "$@"
  local target="$1"
  local destination="${BL64_LOG_REPOSITORY}/${target}"
  local log=''

  # Check if there is a new target to set
  [[ "$BL64_LOG_RUNTIME" == "$destination" ]] && return 0

  if [[ ! -d "$destination" ]]; then
    "$BL64_FS_CMD_MKDIR" "$destination" &&
      "$BL64_FS_CMD_CHMOD" "$BL64_LOG_REPOSITORY_MODE" "$destination" ||
      return $BL64_LIB_ERROR_TASK_FAILED
  fi

  [[ ! -w "$destination" ]] && return $BL64_LIB_ERROR_TASK_FAILED

  log="$(printf '%(%FT%TZ%z)T' '-1')" &&
    BL64_LOG_RUNTIME="${destination}/${log}.log" ||
    return 0

  return 0
}

#######################################
# BashLib64 / Module / Functions / Write messages to logs
#
# Version: 2.0.0
#######################################

#######################################
# Save a log record to the logs repository
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: log message category. Use any of $BL64_LOG_CATEGORY_*
#   $3: message
# Outputs:
#   STDOUT: None
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#   BL64_LIB_ERROR_MODULE_SETUP_MISSING
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function _bl64_log_register() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local category="$2"
  local payload="$3"

  [[ "$BL64_LOG_MODULE" == "$BL64_LIB_VAR_OFF" ]] && return 0
  [[ -z "$source" || -z "$category" || -z "$payload" ]] && return $BL64_LIB_ERROR_PARAMETER_MISSING

  case "$BL64_LOG_FORMAT" in
  "$BL64_LOG_FORMAT_CSV")
    printf '%(%FT%TZ%z)T%s%s%s%s%s%s%s%s%s%s%s%s\n' \
      '-1' \
      "$BL64_LOG_FS" \
      "$BL64_SCRIPT_SID" \
      "$BL64_LOG_FS" \
      "$HOSTNAME" \
      "$BL64_LOG_FS" \
      "$BL64_SCRIPT_ID" \
      "$BL64_LOG_FS" \
      "${source}" \
      "$BL64_LOG_FS" \
      "$category" \
      "$BL64_LOG_FS" \
      "$payload" >>"$BL64_LOG_DESTINATION"
    ;;
  *) return $BL64_LIB_ERROR_MODULE_SETUP_INVALID ;;
  esac
}

#######################################
# Save a single log record of type 'info' to the logs repository.
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: message to be recorded
# Outputs:
#   STDOUT: message (when BL64_LOG_VERBOSE='1')
#   STDERR: execution errors
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_info() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local payload="$2"

  [[ "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_NONE" ||
    "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_ERROR" ||
    "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_WARNING" ]] &&
    return 0

  _bl64_log_register \
    "$source" \
    "$BL64_LOG_CATEGORY_INFO" \
    "$payload"
}

#######################################
# Save a single log record of type 'error' to the logs repository.
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: message to be recorded
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when BL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_error() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local payload="$2"

  [[ "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_NONE" ]] && return 0

  _bl64_log_register \
    "$source" \
    "$BL64_LOG_CATEGORY_ERROR" \
    "$payload"
}

#######################################
# Save a single log record of type 'warning' to the logs repository.
#
# Arguments:
#   $1: name of the source that is generating the message
#   $2: message to be recorded
# Outputs:
#   STDOUT: None
#   STDERR: execution errors, message (when BL64_LOG_VERBOSE='1')
# Returns:
#   0: log record successfully saved
#   >0: failed to save the log record
#######################################
function bl64_log_warning() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local payload="$2"

  [[ "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_NONE" ||
    "$BL64_LOG_LEVEL" == "$BL64_LOG_CATEGORY_ERROR" ]] &&
    return 0

  _bl64_log_register \
    "$source" \
    "$BL64_LOG_CATEGORY_WARNING" \
    "$payload"
}

#######################################
# BashLib64 / Module / Setup / Display messages
#
# Version: 2.3.0
#######################################

#
# Verbosity control
#

function bl64_msg_app_verbose_enabled { [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_APP" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]; }
function bl64_msg_lib_verbose_enabled { [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_LIB" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]; }

function bl64_msg_all_disable_verbose { BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_NONE"; }
function bl64_msg_all_enable_verbose { BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_ALL"; }
function bl64_msg_lib_enable_verbose { BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_LIB"; }
function bl64_msg_app_enable_verbose { BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_APP"; }

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_msg_setup() {
  bl64_dbg_lib_show_function

  # Set default verbosity
  bl64_msg_app_enable_verbose

  bl64_msg_set_output "$BL64_MSG_OUTPUT_ANSI"

  BL64_MSG_MODULE="$BL64_LIB_VAR_ON"
}

#######################################
# Set verbosity level
#
# Arguments:
#   $1: target level. One of BL64_MSG_VERBOSE_*
# Outputs:
#   STDOUT: None
#   STDERR: check error
# Returns:
#   0: set ok
#   >0: unable to set
#######################################
function bl64_msg_set_level() {
  local level="$1"

  bl64_check_parameter 'level' || return $?

  case "$level" in
  "$BL64_MSG_VERBOSE_NONE") bl64_msg_all_disable_verbose ;;
  "$BL64_MSG_VERBOSE_APP") bl64_msg_app_enable_verbose ;;
  "$BL64_MSG_VERBOSE_LIB") bl64_msg_lib_enable_verbose ;;
  "$BL64_MSG_VERBOSE_ALL") bl64_msg_all_enable_verbose ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

#######################################
# Set message format
#
# Arguments:
#   $1: format. One of BL64_MSG_FORMAT_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_format() {
  local format="$1"

  bl64_check_parameter 'format' || return $?

  case "$format" in
  "$BL64_MSG_FORMAT_PLAIN") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_PLAIN" ;;
  "$BL64_MSG_FORMAT_HOST") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_HOST" ;;
  "$BL64_MSG_FORMAT_TIME") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_TIME" ;;
  "$BL64_MSG_FORMAT_CALLER") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_CALLER" ;;
  "$BL64_MSG_FORMAT_FULL") BL64_MSG_FORMAT="$BL64_MSG_FORMAT_FULL" ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

#######################################
# Set message display theme
#
# Arguments:
#   $1: theme name. One of BL64_MSG_THEME_* (variable name, not value)
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_theme() {
  local theme="$1"

  bl64_check_parameter 'theme' || return $?

  case "$theme" in
  'BL64_MSG_THEME_ASCII_STD') BL64_MSG_THEME='BL64_MSG_THEME_ASCII_STD' ;;
  'BL64_MSG_THEME_ANSI_STD') BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD' ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

#######################################
# Set message output type
#
# Arguments:
#   $1: output type. One of BL64_MSG_OUTPUT_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_output() {
  local output="$1"
  bl64_check_parameter 'output' || return $?

  case "$output" in
  "$BL64_MSG_OUTPUT_ASCII")
    BL64_MSG_OUTPUT="$output"
    BL64_MSG_THEME='BL64_MSG_THEME_ASCII_STD'
    ;;
  "$BL64_MSG_OUTPUT_ANSI")
    BL64_MSG_OUTPUT="$output"
    BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD'
    ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Display messages
#
# Version: 3.2.0
#######################################

#######################################
# Display message helper
#
# Arguments:
#   $1: stetic attribute
#   $2: type of message
#   $2: message to show
# Outputs:
#   STDOUT: message
#   STDERR: message when type is error or warning
# Returns:
#   printf exit status
#   BL64_LIB_ERROR_MODULE_SETUP_INVALID
#######################################
function _bl64_msg_show() {
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"

  [[ -n "$attribute" && -n "$type" && -n "$message" ]] || return $BL64_LIB_ERROR_PARAMETER_MISSING

  case "$BL64_MSG_OUTPUT" in
  "$BL64_MSG_OUTPUT_ASCII") _bl64_msg_show_ascii "$attribute" "$type" "$message" ;;
  "$BL64_MSG_OUTPUT_ANSI") _bl64_msg_show_ansi "$attribute" "$type" "$message" ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

function _bl64_msg_show_ansi() {

  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local style=''
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'

  [[ -n "$attribute" && -n "$type" && -n "$message" ]] || return $BL64_LIB_ERROR_PARAMETER_MISSING
  style="${BL64_MSG_THEME}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  case "$BL64_MSG_FORMAT" in
  "$BL64_MSG_FORMAT_PLAIN")
    printf "%b: %s${linefeed}" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_HOST")
    printf "[%b] %b: %s${linefeed}" \
      "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_TIME")
    printf "[%b] %b: %s${linefeed}" \
      "\e[${!style_fmttime}m$(printf '%(%d/%b/%Y-%H:%M:%S-UTC%z)T' '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_CALLER")
    printf "[%b] %b: %s${linefeed}" \
      "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_FULL")
    printf "[%b] %b:%b | %b: %s${linefeed}" \
      "\e[${!style_fmttime}m$(printf '%(%d/%b/%Y-%H:%M:%S-UTC%z)T' '-1')\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style_fmthost}m${HOSTNAME}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style_fmtcaller}m${BL64_SCRIPT_ID}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "\e[${!style}m${type}\e[${BL64_MSG_ANSI_CHAR_NORMAL}m" \
      "$message"
    ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

function _bl64_msg_show_ascii() {
  local attribute="${1:-}"
  local type="${2:-}"
  local message="${3:-}"
  local style=''
  local style_fmttime="${BL64_MSG_THEME}_FMTTIME"
  local style_fmthost="${BL64_MSG_THEME}_FMTHOST"
  local style_fmtcaller="${BL64_MSG_THEME}_FMTCALLER"
  local linefeed='\n'

  [[ -n "$attribute" && -n "$type" && -n "$message" ]] || return $BL64_LIB_ERROR_PARAMETER_MISSING
  style="${BL64_MSG_THEME}_${attribute}"
  [[ "$attribute" == "$BL64_MSG_TYPE_INPUT" ]] && linefeed=''

  case "$BL64_MSG_FORMAT" in
  "$BL64_MSG_FORMAT_PLAIN")
    printf "%s: %s${linefeed}" \
      "${!style} $type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_HOST")
    printf "[%s] %s: %s${linefeed}" \
      "${HOSTNAME}" \
      "${!style} $type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_TIME")
    printf "[%(%d/%b/%Y-%H:%M:%S-UTC%z)T] %s: %s${linefeed}" \
      '-1' \
      "${!style} $type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_CALLER")
    printf "[%s] %s: %s${linefeed}" \
      "$BL64_SCRIPT_ID" \
      "${!style} $type" \
      "$message"
    ;;
  "$BL64_MSG_FORMAT_FULL")
    printf "[%(%d/%b/%Y-%H:%M:%S-UTC%z)T] %s:%s | %s: %s${linefeed}" \
      '-1' \
      "$HOSTNAME" \
      "$BL64_SCRIPT_ID" \
      "${!style} $type" \
      "$message"
    ;;
  *) bl64_check_alert_parameter_invalid ;;
  esac
}

#######################################
# Show script usage information
#
# Arguments:
#   $1: script command line. Include all required and optional components
#   $2: full script usage description
#   $3: list of script commands
#   $4: list of script flags
#   $5: list of script parameters
# Outputs:
#   STDOUT: usage info
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_usage() {
  local usage="${1:-${BL64_LIB_VAR_NULL}}"
  local description="${2:-${BL64_LIB_DEFAULT}}"
  local commands="${3:-${BL64_LIB_DEFAULT}}"
  local flags="${4:-${BL64_LIB_DEFAULT}}"
  local parameters="${5:-${BL64_LIB_DEFAULT}}"

  bl64_check_parameter 'usage' || return $?

  printf '\n%s: %s %s\n\n' "$_BL64_MSG_TXT_USAGE" "$BL64_SCRIPT_ID" "$usage"

  if [[ "$description" != "$BL64_LIB_DEFAULT" ]]; then
    printf '%s\n\n' "$description"
  fi

  if [[ "$commands" != "$BL64_LIB_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_COMMANDS" "$commands"
  fi

  if [[ "$flags" != "$BL64_LIB_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_FLAGS" "$flags"
  fi

  if [[ "$parameters" != "$BL64_LIB_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_PARAMETERS" "$parameters"
  fi

  return 0
}

#######################################
# Display error message
#
# Arguments:
#   $1: error message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_error() {
  local message="$1"

  bl64_log_error "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_show "$BL64_MSG_TYPE_ERROR" "$_BL64_MSG_TXT_ERROR" "$message" >&2
}

#######################################
# Display warning message
#
# Arguments:
#   $1: warning message
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_warning() {
  local message="$1"

  bl64_log_warning "${FUNCNAME[1]:-MAIN}" "$message" &&
    _bl64_msg_show "$BL64_MSG_TYPE_WARNING" "$_BL64_MSG_TXT_WARNING" "$message" >&2
}

#######################################
# Display info message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_info() {
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_INFO" "$_BL64_MSG_TXT_INFO" "$message"
}

#######################################
# Display task message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_task() {
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_TASK}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_TASK" "$_BL64_MSG_TXT_TASK" "$message"
}

#######################################
# Display task message for bash64lib functions
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_lib_task() {
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBTASK}:${message}" &&
    bl64_msg_lib_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_LIBTASK" "$_BL64_MSG_TXT_TASK" "$message"
}

#######################################
# Display message. Plain output, no extra info.
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_text() {
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_verbose_enabled || return 0

  printf '%s\n' "$message"
}

#######################################
# Display batch process start message
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_batch_start() {
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_BATCH}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_BATCH" "$_BL64_MSG_TXT_BATCH" "[${message}] ${_BL64_MSG_TXT_BATCH_START}"
}

#######################################
# Display batch process complete message
#
# Arguments:
#   $1: process exit status
#   $2: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_batch_finish() {
  local status="$1"
  local message="${2-${BL64_LIB_DEFAULT}}"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_BATCH}:${status}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  if ((status == 0)); then
    _bl64_msg_show "$BL64_MSG_TYPE_BATCHOK" "$_BL64_MSG_TXT_BATCH" "[${message}] ${_BL64_MSG_TXT_BATCH_FINISH_OK}"
  else
    _bl64_msg_show "$BL64_MSG_TYPE_BATCHERR" "$_BL64_MSG_TXT_BATCH" "[${message}] ${_BL64_MSG_TXT_BATCH_FINISH_ERROR}: exit-status-${status}"
  fi
}

#######################################
# Display user input message
#
# * Used exclusively by the io module to show messages for user input from stdin
#
# Arguments:
#   $1: message
# Outputs:
#   STDOUT: message
#   STDERR: None
# Returns:
#   0: successfull execution
#   >0: printf error
#######################################
function bl64_msg_show_input() {
  local message="$1"

  _bl64_msg_show "$BL64_MSG_TYPE_INPUT" "$_BL64_MSG_TXT_INPUT" "$message"
}

#######################################
# BashLib64 / Module / Setup / OS / Identify OS attributes and provide command aliases
#
# Version: 2.1.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_os_setup() {
  bl64_dbg_lib_show_function

  [[ "${BASH_VERSINFO[0]}" != '4' && "${BASH_VERSINFO[0]}" != '5' ]] &&
    bl64_msg_show_error "BashLib64 is not supported in the current Bash version (${BASH_VERSINFO[0]})" &&
    return $BL64_LIB_ERROR_OS_BASH_VERSION

  bl64_os_get_distro &&
    bl64_os_set_command &&
    BL64_OS_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function bl64_os_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/bin/false'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_TRUE='/bin/true'
    BL64_OS_CMD_UNAME='/bin/uname'
    BL64_OS_CMD_BASH='/bin/bash'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_OS_CMD_CAT='/usr/bin/cat'
    BL64_OS_CMD_DATE=/usr'/bin/date'
    BL64_OS_CMD_FALSE='/usr/bin/false'
    BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
    BL64_OS_CMD_TRUE='/usr/bin/true'
    BL64_OS_CMD_UNAME='/bin/uname'
    BL64_OS_CMD_BASH='/bin/bash'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/bin/false'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_TRUE='/bin/true'
    BL64_OS_CMD_UNAME='/bin/uname'
    BL64_OS_CMD_BASH='/bin/bash'
    ;;
  ${BL64_OS_MCOS}-*)
    # Homebrew used when no native option available
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/usr/bin/false'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_TRUE='/usr/bin/true'
    BL64_OS_CMD_UNAME='/usr/bin/uname'
    BL64_OS_CMD_BASH='/opt/homebre/bin/bash'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / OS / Identify OS attributes and provide command aliases
#
# Version: 1.16.0
#######################################

function _bl64_os_match() {
  bl64_dbg_lib_show_function "$@"
  local os="$1"
  local item="$2"
  local version="${item##*-}"

  # Pattern: OOO-V.V
  if [[ "$item" == +([[:alpha:]])-+([[:digit:]]).+([[:digit:]]) ]]; then
    [[ "$BL64_OS_DISTRO" == "${os}-${version}" ]]
  # Pattern: OOO-V
  elif [[ "$item" == +([[:alpha:]])-+([[:digit:]]) ]]; then
    [[ "$BL64_OS_DISTRO" == ${os}-${version}.+([[:digit:]]) ]]
  # Pattern: OOO
  else
    [[ "$BL64_OS_DISTRO" == ${os}-+([[:digit:]]).+([[:digit:]]) ]]
  fi
}

# Warning: bootstrap function
function _bl64_os_get_distro_from_uname() {
  bl64_dbg_lib_show_function
  local os_type=''
  local os_version=''
  local cmd_sw_vers='/usr/bin/sw_vers'

  os_type="$(uname)"
  case "$os_type" in
  'Darwin')
    os_version="$("$cmd_sw_vers" -productVersion)"
    BL64_OS_DISTRO="DARWIN-${os_version}"
    ;;
  *) BL64_OS_DISTRO="$BL64_OS_UNK" ;;
  esac

  if [[ "$BL64_OS_DISTRO" == "$BL64_OS_UNK" ]]; then
    bl64_msg_show_error "BashLib64 is not supported in the current OS ($(uname -a))"
    return $BL64_LIB_ERROR_OS_INCOMPATIBLE
  fi

  return 0
}

# Warning: bootstrap function
function _bl64_os_get_distro_from_os_release() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC1091
  source '/etc/os-release'
  if [[ -n "${ID:-}" && -n "${VERSION_ID:-}" ]]; then
    BL64_OS_DISTRO="${ID^^}-${VERSION_ID}"
  fi

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_ALM}-8*) : ;;
  ${BL64_OS_ALP}-3*) : ;;
  ${BL64_OS_CNT}-7*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_CNT}-7" ]] && BL64_OS_DISTRO="${BL64_OS_CNT}-7.0"
    ;;
  ${BL64_OS_CNT}-8*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_CNT}-8" ]] && BL64_OS_DISTRO="${BL64_OS_CNT}-8.0"
    ;;
  ${BL64_OS_CNT}-9*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_CNT}-9" ]] && BL64_OS_DISTRO="${BL64_OS_CNT}-9.0"
    ;;
  ${BL64_OS_DEB}-9*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-9" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-9.0"
    ;;
  ${BL64_OS_DEB}-10*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-10" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-10.0"
    ;;
  ${BL64_OS_DEB}-11*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-11" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-11.0"
    ;;
  ${BL64_OS_FD}-33*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-33" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-33.0"
    ;;
  ${BL64_OS_FD}-34*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-34" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-34.0"
    ;;
  ${BL64_OS_FD}-35*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-35" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-35.0"
    ;;
  ${BL64_OS_FD}-36*)
    [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-36" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-36.0"
    ;;
  ${BL64_OS_OL}-7* | ${BL64_OS_OL}-8* | ${BL64_OS_OL}-9*) : ;;
  ${BL64_OS_RCK}-8*) : ;;
  ${BL64_OS_RHEL}-8* | ${BL64_OS_RHEL}-9*) : ;;
  ${BL64_OS_UB}-20* | ${BL64_OS_UB}-21* | ${BL64_OS_UB}-22*) : ;;
  *) BL64_OS_DISTRO="$BL64_OS_UNK" ;;
  esac

  if [[ "$BL64_OS_DISTRO" == "$BL64_OS_UNK" ]]; then
    bl64_msg_show_error "BashLib64 is not supported in the current OS (ID=${ID:-NONE} | VERSION_ID=${VERSION_ID:-NONE})"
    return $BL64_LIB_ERROR_OS_INCOMPATIBLE
  fi

  return 0
}

#######################################
# Check if the current OS matches the target list
#
# Arguments:
#   $@: list of normalized OS names. Formats: as defined by bl64_os_get_distro
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   BL64_LIB_ERROR_OS_NOT_MATCH
#   BL64_LIB_ERROR_OS_TAG_INVALID
#######################################

function bl64_os_match() {
  bl64_dbg_lib_show_function "$@"
  local item=''

  bl64_dbg_lib_show_info "[OSList=${*}}] / [BL64_OS_DISTRO=${BL64_OS_DISTRO}]"
  # shellcheck disable=SC2086
  for item in "$@"; do
    case "$item" in
    'ALM' | ALM-*) _bl64_os_match "$BL64_OS_ALM" "$item" && return 0 ;;
    'ALP' | ALP-*) _bl64_os_match "$BL64_OS_ALP" "$item" && return 0 ;;
    'CNT' | CNT-*) _bl64_os_match "$BL64_OS_CNT" "$item" && return 0 ;;
    'DEB' | DEB-*) _bl64_os_match "$BL64_OS_DEB" "$item" && return 0 ;;
    'FD' | FD-*) _bl64_os_match "$BL64_OS_FD" "$item" && return 0 ;;
    'MCOS' | MCOS-*) _bl64_os_match "$BL64_OS_MCOS" "$item" && return 0 ;;
    'OL' | OL-*) _bl64_os_match "$BL64_OS_OL" "$item" && return 0 ;;
    'RCK' | RCK-*) _bl64_os_match "$BL64_OS_RCK" "$item" && return 0 ;;
    'RHEL' | RHEL-*) _bl64_os_match "$BL64_OS_RHEL" "$item" && return 0 ;;
    'UB' | UB-*) _bl64_os_match "$BL64_OS_UB" "$item" && return 0 ;;
    *) return $BL64_LIB_ERROR_OS_TAG_INVALID ;;
    esac
  done

  # shellcheck disable=SC2086
  return $BL64_LIB_ERROR_OS_NOT_MATCH
}

#######################################
# Identify and normalize Linux OS distribution name and version
#
# * Warning: bootstrap function
# * OS name format: OOO-V.V
#   * OOO: OS short name (tag)
#   * V.V: Version (Major, Minor)
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function bl64_os_get_distro() {
  bl64_dbg_lib_show_function
  if [[ -r '/etc/os-release' ]]; then
    _bl64_os_get_distro_from_os_release
  else
    _bl64_os_get_distro_from_uname
  fi
}

#######################################
# BashLib64 / Module / Setup / Manage native OS packages
#
# Version: 1.4.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_pkg_setup() {
  bl64_dbg_lib_show_function

  bl64_pkg_set_command &&
    bl64_pkg_set_paths &&
    bl64_pkg_set_alias &&
    bl64_pkg_set_options &&
    BL64_PKG_MODULE="$BL64_LIB_VAR_ON"
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_pkg_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-*)
    BL64_PKG_CMD_DNF='/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    BL64_PKG_CMD_DNF='/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.*)
    BL64_PKG_CMD_DNF='/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    BL64_PKG_CMD_YUM='/usr/bin/yum'
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_PKG_CMD_APT='/usr/bin/apt-get'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_PKG_CMD_APK='/sbin/apk'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_PKG_CMD_BRW='/opt/homebrew/bin/brew'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_pkg_set_options() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-*)
    BL64_PKG_SET_ASSUME_YES='--assumeyes'
    BL64_PKG_SET_SLIM='--nodocs'
    BL64_PKG_SET_QUIET='--quiet'
    BL64_PKG_SET_VERBOSE='--color=never --verbose'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    BL64_PKG_SET_ASSUME_YES='--assumeyes'
    BL64_PKG_SET_SLIM='--nodocs'
    BL64_PKG_SET_QUIET='--quiet'
    BL64_PKG_SET_VERBOSE='--color=never --verbose'
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.*)
    BL64_PKG_SET_ASSUME_YES='--assumeyes'
    BL64_PKG_SET_SLIM='--nodocs'
    BL64_PKG_SET_QUIET='--quiet'
    BL64_PKG_SET_VERBOSE='--color=never --verbose'
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    BL64_PKG_SET_ASSUME_YES='--assumeyes'
    BL64_PKG_SET_SLIM=' '
    BL64_PKG_SET_QUIET='--quiet'
    BL64_PKG_SET_VERBOSE='--color=never --verbose'
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_PKG_SET_ASSUME_YES='--assume-yes'
    BL64_PKG_SET_SLIM=' '
    BL64_PKG_SET_QUIET='--quiet --quiet'
    BL64_PKG_SET_VERBOSE='--show-progress'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_PKG_SET_ASSUME_YES=' '
    BL64_PKG_SET_SLIM=' '
    BL64_PKG_SET_QUIET='--quiet'
    BL64_PKG_SET_VERBOSE='--verbose'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_PKG_SET_ASSUME_YES=' '
    BL64_PKG_SET_SLIM=' '
    BL64_PKG_SET_QUIET='--quiet'
    BL64_PKG_SET_VERBOSE='--verbose'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_pkg_set_alias() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-*)
    BL64_PKG_ALIAS_DNF_CACHE="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} makecache"
    BL64_PKG_ALIAS_DNF_INSTALL="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} ${BL64_PKG_SET_SLIM} ${BL64_PKG_SET_ASSUME_YES} install"
    BL64_PKG_ALIAS_DNF_CLEAN="$BL64_PKG_CMD_DNF clean all"
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    BL64_PKG_ALIAS_DNF_CACHE="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} makecache"
    BL64_PKG_ALIAS_DNF_INSTALL="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} ${BL64_PKG_SET_SLIM} ${BL64_PKG_SET_ASSUME_YES} install"
    BL64_PKG_ALIAS_DNF_CLEAN="$BL64_PKG_CMD_DNF clean all"
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.*)
    BL64_PKG_ALIAS_DNF_CACHE="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} makecache"
    BL64_PKG_ALIAS_DNF_INSTALL="$BL64_PKG_CMD_DNF ${BL64_PKG_SET_VERBOSE} ${BL64_PKG_SET_SLIM} ${BL64_PKG_SET_ASSUME_YES} install"
    BL64_PKG_ALIAS_DNF_CLEAN="$BL64_PKG_CMD_DNF clean all"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    BL64_PKG_ALIAS_YUM_CACHE="$BL64_PKG_CMD_YUM ${BL64_PKG_SET_VERBOSE} makecache"
    BL64_PKG_ALIAS_YUM_INSTALL="$BL64_PKG_CMD_YUM ${BL64_PKG_SET_VERBOSE} ${BL64_PKG_SET_ASSUME_YES} install"
    BL64_PKG_ALIAS_YUM_CLEAN="$BL64_PKG_CMD_YUM clean all"
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_PKG_ALIAS_APT_CACHE="$BL64_PKG_CMD_APT update ${BL64_PKG_SET_VERBOSE}"
    BL64_PKG_ALIAS_APT_INSTALL="$BL64_PKG_CMD_APT install ${BL64_PKG_SET_ASSUME_YES} ${BL64_PKG_SET_VERBOSE}"
    BL64_PKG_ALIAS_APT_CLEAN="$BL64_PKG_CMD_APT clean"
    ;;
  ${BL64_OS_ALP}-*)
    BL64_PKG_ALIAS_APK_CACHE="$BL64_PKG_CMD_APK update ${BL64_PKG_SET_VERBOSE}"
    BL64_PKG_ALIAS_APK_INSTALL="$BL64_PKG_CMD_APK add ${BL64_PKG_SET_VERBOSE}"
    BL64_PKG_ALIAS_APK_CLEAN="$BL64_PKG_CMD_APK cache clean ${BL64_PKG_SET_VERBOSE}"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_PKG_ALIAS_BRW_CACHE="$BL64_PKG_CMD_BRW update ${BL64_PKG_SET_VERBOSE}"
    BL64_PKG_ALIAS_BRW_INSTALL="$BL64_PKG_CMD_BRW install ${BL64_PKG_SET_VERBOSE}"
    BL64_PKG_ALIAS_BRW_CLEAN="$BL64_PKG_CMD_BRW cleanup ${BL64_PKG_SET_VERBOSE} --prune=all -s"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Set and prepare module paths
#
# * Global paths only
# * If preparation fails the whole module fails
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: check errors
# Returns:
#   0: paths prepared ok
#   >0: failed to prepare paths
#######################################
# shellcheck disable=SC2120
function bl64_pkg_set_paths() {
  bl64_dbg_lib_show_function

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-*)
    BL64_PKG_PATH_YUM_REPOS_D='/etc/yum.repos.d/'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    BL64_PKG_PATH_YUM_REPOS_D='/etc/yum.repos.d/'
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.*)
    BL64_PKG_PATH_YUM_REPOS_D='/etc/yum.repos.d/'
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    BL64_PKG_PATH_YUM_REPOS_D='/etc/yum.repos.d/'
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    :
    ;;
  ${BL64_OS_ALP}-*)
    :
    ;;
  ${BL64_OS_MCOS}-*)
    :
    ;;
  *) bl64_check_alert_unsupported ;;
  esac

  return 0
}

#######################################
# BashLib64 / Module / Functions / Manage native OS packages
#
# Version: 2.2.1
#######################################

#######################################
# Add package repository
#
# * Add remote package repository
# * Package cache is not refreshed
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   $1: repository name
#   $2: repository source. Format: URL
#   $3: GPGKey source (YUM only). Format: URL
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   package manager exit status
#######################################
function bl64_pkg_repository_add() {
  bl64_dbg_lib_show_function "$@"
  local repository="$1"
  local source="$2"
  local gpgkey="${3:-${BL64_LIB_VAR_NULL}}"
  local definition=''

  bl64_check_privilege_root &&
    bl64_check_parameter 'repository' &&
    bl64_check_parameter 'source' ||
    return $?

  bl64_msg_show_lib_task "$_BL64_PKG_TXT_REPOSITORY_ADD (${repository})"
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-* | \
    ${BL64_OS_RHEL}-8.* | ${BL64_OS_RHEL}-9.* | \
    ${BL64_OS_ALM}-8.* | \
    ${BL64_OS_RCK}-8.* | \
    ${BL64_OS_CNT}-7.* | ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | \
    ${BL64_OS_OL}-7.* | ${BL64_OS_OL}-8.* | ${BL64_OS_OL}-9.*)

    bl64_check_parameter 'gpgkey' || return $?
    definition="${BL64_PKG_PATH_YUM_REPOS_D}/${repository}.${BL64_PKG_DEF_SUFFIX_YUM_REPOSITORY}"
    [[ -f "$definition" ]] && bl64_dbg_lib_show_info "repository already created (${definition}). No action taken" && return 0

    bl64_dbg_lib_show_info "create repository definition (${definition})"
    printf '[%s]
name=%s
baseurl=%s
gpgcheck=1
enabled=1
gpgkey=%s\n' \
      "$repository" \
      "$repository" \
      "$source" \
      "$gpgkey" \
      >"$definition"
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_check_alert_unsupported
    ;;
  ${BL64_OS_ALP}-*)
    bl64_check_alert_unsupported
    ;;
  ${BL64_OS_MCOS}-*)
    bl64_check_alert_unsupported
    ;;
  *) bl64_check_alert_unsupported ;;

  esac
}

#######################################
# Refresh package repository
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_repository_refresh() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_task "$_BL64_PKG_TXT_REPOSITORY_REFRESH"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-*)
    bl64_pkg_run_dnf 'makecache'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    bl64_pkg_run_dnf 'makecache'
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.*)
    bl64_pkg_run_dnf 'makecache'
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    bl64_pkg_run_yum 'makecache'
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_pkg_run_apt 'update'
    ;;
  ${BL64_OS_ALP}-*)
    bl64_pkg_run_apk 'update'
    ;;
  ${BL64_OS_MCOS}-*)
    bl64_pkg_run_brew 'update'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Deploy packages
#
# * Before installation: prepares the package manager environment and cache
# * After installation: removes cache and temporary files
#
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: process output
#   STDERR: process stderr
# Returns:
#   n: process exist status
#######################################
function bl64_pkg_deploy() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none $# || return $?

  bl64_pkg_prepare &&
    bl64_pkg_install "$@" &&
    bl64_pkg_upgrade &&
    bl64_pkg_cleanup
}

#######################################
# Initialize the package manager for installations
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_prepare() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_task "$_BL64_PKG_TXT_PREPARE"
  bl64_pkg_repository_refresh
}

#######################################
# Install packages
#
# * Assume yes
# * Avoid installing docs (man) when possible
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_install() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none $# || return $?

  bl64_msg_show_lib_task "$_BL64_PKG_TXT_INSTALL (${*})"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    bl64_pkg_run_yum $BL64_PKG_SET_ASSUME_YES 'install' -- "$@"
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_pkg_run_apt 'install' $BL64_PKG_SET_ASSUME_YES -- "$@"
    ;;
  ${BL64_OS_ALP}-*)
    bl64_pkg_run_apk 'add' -- "$@"
    ;;
  ${BL64_OS_MCOS}-*)
    "$BL64_PKG_CMD_BRW" 'install' "$@"
    ;;
  *) bl64_check_alert_unsupported ;;

  esac
}

#######################################
# Upgrade packages
#
# * Assume yes
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
# shellcheck disable=SC2120
function bl64_pkg_upgrade() {
  bl64_dbg_lib_show_function "$@"

  bl64_msg_show_lib_task "$_BL64_PKG_TXT_UPGRADE"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' -- "$@"
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' -- "$@"
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.*)
    bl64_pkg_run_dnf $BL64_PKG_SET_SLIM $BL64_PKG_SET_ASSUME_YES 'upgrade' -- "$@"
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    bl64_pkg_run_yum $BL64_PKG_SET_ASSUME_YES 'upgrade' -- "$@"
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_pkg_run_apt 'upgrade' $BL64_PKG_SET_ASSUME_YES -- "$@"
    ;;
  ${BL64_OS_ALP}-*)
    bl64_pkg_run_apk 'upgrade' -- "$@"
    ;;
  ${BL64_OS_MCOS}-*)
    "$BL64_PKG_CMD_BRW" 'upgrade' "$@"
    ;;
  *) bl64_check_alert_unsupported ;;

  esac
}

#######################################
# Clean up the package manager run-time environment
#
# * Warning: removes cache contents
#
# Requirements:
#   * root privilege (sudo)
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_pkg_cleanup() {
  bl64_dbg_lib_show_function
  local target=''

  bl64_msg_show_lib_task "$_BL64_PKG_TXT_CLEAN"
  # shellcheck disable=SC2086
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_FD}-*)
    bl64_pkg_run_dnf 'clean' 'all'
    ;;
  ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
    BL64_PKG_CMD_DNF='/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.*)
    BL64_PKG_CMD_DNF='/usr/bin/dnf'
    ;;
  ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
    bl64_pkg_run_yum 'clean' 'all'
    ;;
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_pkg_run_apt 'clean'
    ;;
  ${BL64_OS_ALP}-*)
    bl64_pkg_run_apk 'cache' 'clean'
    target='/var/cache/apk'
    if [[ -d "$target" ]]; then
      bl64_fs_rm_full ${target}/[[:alpha:]]*
    fi
    ;;
  ${BL64_OS_MCOS}-*)
    bl64_pkg_run_brew 'cleanup' --prune=all -s
    ;;
  *) bl64_check_alert_unsupported ;;

  esac
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_dnf() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_DNF" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_yum() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_YUM" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_apt() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root ||
    return $?

  bl64_pkg_blank_apt

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    export DEBCONF_NOWARNINGS='yes'
    export DEBCONF_TERSE='yes'
    verbose="$BL64_PKG_SET_QUIET"
  fi

  # Avoid interactive questions
  export DEBIAN_FRONTEND="noninteractive"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_APT" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_pkg_blank_apt() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited DEB* shell variables'
  bl64_dbg_lib_trace_start
  unset DEBIAN_FRONTEND
  unset DEBCONF_TERSE
  unset DEBCONF_NOWARNINGS
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_apk() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_APK" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_pkg_run_brew() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" &&
    bl64_check_privilege_root ||
    return $?

  if bl64_dbg_lib_command_enabled; then
    verbose="$BL64_PKG_SET_VERBOSE"
  else
    verbose="$BL64_PKG_SET_QUIET"
  fi

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_PKG_CMD_BRW" $verbose "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# BashLib64 / Module / Setup / Interact with system-wide Python
#
# Version: 1.11.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * (Optional) Use virtual environment
#
# Arguments:
#   $1: full path to the virtual environment
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
# shellcheck disable=SC2120
function bl64_py_setup() {
  bl64_dbg_lib_show_function "$@"
  local venv_path="${1:-${BL64_LIB_DEFAULT}}"

  if [[ "$venv_path" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_dbg_lib_show_info "venv requested (${venv_path})"
    if [[ -d "$venv_path" ]]; then
      bl64_dbg_lib_show_info 'use already existing venv'
      _bl64_py_setup "$venv_path"
    else
      bl64_dbg_lib_show_info 'no previous venv, create one'
      _bl64_py_setup "$BL64_LIB_DEFAULT" &&
        bl64_py_venv_create "$venv_path" &&
        _bl64_py_setup "$venv_path"
    fi
  else
    bl64_dbg_lib_show_info "no venv requested"
    _bl64_py_setup "$BL64_LIB_DEFAULT"
  fi
}

function _bl64_py_setup() {
  bl64_dbg_lib_show_function "$@"
  local venv_path="$1"

  if [[ "$venv_path" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_py_venv_check "$venv_path" ||
      return $?
  fi

  bl64_py_set_command "$venv_path" &&
    bl64_check_command "$BL64_PY_CMD_PYTHON3" &&
    bl64_py_set_options &&
    bl64_py_set_definitions &&
    BL64_PY_MODULE="$BL64_LIB_VAR_ON"
}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * (Optional) Enable requested virtual environment
# * If virtual environment is requested, instead of running bin/activate manually set the same variables that it would
#
# Arguments:
#   $1: full path to the virtual environment
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_py_set_command() {
  bl64_dbg_lib_show_function "$@"
  local venv_path="$1"

  if [[ "$venv_path" == "$BL64_LIB_DEFAULT" ]]; then
    bl64_dbg_lib_show_info 'identify OS native python3 path'
    # Define distro native Python versions
    # shellcheck disable=SC2034
    case "$BL64_OS_DISTRO" in
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*) BL64_PY_CMD_PYTHON36='/usr/bin/python3' ;;
    ${BL64_OS_CNT}-8.* | ${BL64_OS_OL}-8.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_ALM}-8.* | ${BL64_OS_RCK}-8.*)
      BL64_PY_CMD_PYTHON36='/usr/bin/python3'
      BL64_PY_CMD_PYTHON39='/usr/bin/python3.9'
      ;;
    ${BL64_OS_CNT}-9.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RHEL}-9.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    ${BL64_OS_FD}-33.* | ${BL64_OS_FD}-34.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    ${BL64_OS_FD}-35.* | ${BL64_OS_FD}-36.*) BL64_PY_CMD_PYTHON310='/usr/bin/python3.10' ;;
    ${BL64_OS_DEB}-9.*) BL64_PY_CMD_PYTHON35='/usr/bin/python3.5' ;;
    ${BL64_OS_DEB}-10.*) BL64_PY_CMD_PYTHON37='/usr/bin/python3.7' ;;
    ${BL64_OS_DEB}-11.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    ${BL64_OS_UB}-20.*) BL64_PY_CMD_PYTHON38='/usr/bin/python3.8' ;;
    ${BL64_OS_UB}-21.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    ${BL64_OS_UB}-22.*) BL64_PY_CMD_PYTHON310='/usr/bin/python3.10' ;;
    ${BL64_OS_ALP}-3.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    ${BL64_OS_MCOS}-12.*) BL64_PY_CMD_PYTHON39='/usr/bin/python3.9' ;;
    *) bl64_check_alert_unsupported ;;
    esac

    # Select best match for default python3
    if [[ -x "$BL64_PY_CMD_PYTHON310" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON310"
      BL64_PY_VERSION_PYTHON3='3.10'
    elif [[ -x "$BL64_PY_CMD_PYTHON39" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON39"
      BL64_PY_VERSION_PYTHON3='3.9'
    elif [[ -x "$BL64_PY_CMD_PYTHON38" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON38"
      BL64_PY_VERSION_PYTHON3='3.8'
    elif [[ -x "$BL64_PY_CMD_PYTHON37" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON37"
      BL64_PY_VERSION_PYTHON3='3.7'
    elif [[ -x "$BL64_PY_CMD_PYTHON36" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON36"
      BL64_PY_VERSION_PYTHON3='3.6'
    elif [[ -x "$BL64_PY_CMD_PYTHON35" ]]; then
      BL64_PY_CMD_PYTHON3="$BL64_PY_CMD_PYTHON35"
      BL64_PY_VERSION_PYTHON3='3.5'
    fi

    # Ignore VENV. Use detected python
    export VIRTUAL_ENV=''

  else
    bl64_dbg_lib_show_info 'use python3 from virtual environment'
    BL64_PY_CMD_PYTHON3="${venv_path}/bin/python3"

    # Emulate bin/activate
    export VIRTUAL_ENV="$venv_path"
    export PATH="${VIRTUAL_ENV}:${PATH}"
    unset PYTHONHOME

    # Let other basthlib64 functions know about this venv
    BL64_PY_VENV_PATH="$venv_path"
  fi

  bl64_dbg_lib_show_vars 'BL64_PY_CMD_PYTHON3' 'BL64_PY_VENV_PATH' 'VIRTUAL_ENV' 'PATH'
}

#######################################
# Create command sets for common options
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_py_set_options() {
  bl64_dbg_lib_show_function
  # Common sets - unversioned
  BL64_PY_SET_PIP_VERBOSE='--verbose'
  BL64_PY_SET_PIP_DEBUG='-vvv'
  BL64_PY_SET_PIP_VERSION='--version'
  BL64_PY_SET_PIP_UPGRADE='--upgrade'
  BL64_PY_SET_PIP_USER='--user'
  BL64_PY_SET_PIP_QUIET='--quiet'
  BL64_PY_SET_PIP_SITE='--system-site-packages'
  BL64_PY_SET_PIP_NO_WARN_SCRIPT='--no-warn-script-location'

}

#######################################
# Declare version specific definitions
#
# * Use to capture default file names, values, attributes, etc
# * Do not use to capture CLI flags. Use *_set_options instead
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_py_set_definitions() {
  bl64_dbg_lib_show_function

  BL64_PY_DEF_VENV_CFG='pyvenv.cfg'
  BL64_PY_DEF_MODULE_VENV='venv'
  BL64_PY_DEF_MODULE_PIP='pip'

  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with system-wide Python
#
# Version: 1.11.0
#######################################

#######################################
# Create virtual environment
#
# Arguments:
#   $1: full path to the virtual environment
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_py_venv_create() {
  bl64_dbg_lib_show_function "$@"
  local venv_path="${1:-}"

  bl64_check_parameter 'venv_path' &&
    bl64_check_path_absolute "$venv_path" &&
    bl64_check_path_not_present "$venv_path" ||
    return $?

  bl64_msg_show_lib_task "${_BL64_PY_TXT_VENV_CREATE} (${venv_path})"
  bl64_py_run_python -m "$BL64_PY_DEF_MODULE_VENV" "$venv_path"

}

#######################################
# Check that the requested virtual environment is created
#
# Arguments:
#   $1: full path to the virtual environment
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_py_venv_check() {
  bl64_dbg_lib_show_function "$@"
  local venv_path="${1:-}"

  bl64_check_parameter 'venv_path' ||
    return $?

  if [[ ! -d "$venv_path" ]]; then
    bl64_msg_show_error "${message} (command: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_PY_TXT_VENV_MISSING}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_MODULE_SETUP_MISSING
  fi

  if [[ ! -r "${venv_path}/${BL64_PY_DEF_VENV_CFG}" ]]; then
    bl64_msg_show_error "${message} (command: ${path} ${_BL64_CHECK_TXT_I} ${_BL64_PY_TXT_VENV_INVALID}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_MODULE_SETUP_INVALID
  fi

  return 0
}

#######################################
# Get Python PIP version
#
# Arguments:
#   None
# Outputs:
#   STDOUT: PIP version
#   STDERR: PIP error
# Returns:
#   0: ok
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#######################################
function bl64_py_pip_get_version() {
  bl64_dbg_lib_show_function
  local -a version

  read -r -a version < <(bl64_py_run_pip "$BL64_PY_SET_PIP_VERSION")
  if [[ "${version[1]}" == [0-9.]* ]]; then
    printf '%s' "${version[1]}"
  else
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_INCOMPATIBLE
  fi

  return 0
}

#######################################
# Initialize package manager for local-user
#
# * Upgrade pip
# * Install/upgrade setuptools
# * Upgrade is done using the OS provided PIP module. Do not use bl64_py_pip_usr_install as it relays on the latest version of PIP
#
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_py_pip_usr_prepare() {
  bl64_dbg_lib_show_function
  local modules_pip="$BL64_PY_DEF_MODULE_PIP"
  local modules_setup='setuptools wheel stevedore'
  local flag_user="$BL64_PY_SET_PIP_USER"

  [[ -n "$VIRTUAL_ENV" ]] && flag_user=' '

  # shellcheck disable=SC2086
  bl64_msg_show_lib_task "$_BL64_PY_TXT_PIP_PREPARE_PIP" &&
    bl64_py_run_pip \
      'install' \
      $BL64_PY_SET_PIP_UPGRADE \
      $flag_user \
      $modules_pip &&
    bl64_msg_show_lib_task "$_BL64_PY_TXT_PIP_PREPARE_SETUP" &&
    bl64_py_run_pip \
      'install' \
      $BL64_PY_SET_PIP_UPGRADE \
      $flag_user \
      $modules_setup

}

#######################################
# Install packages for local-user
#
# * Assume yes
# * Assumes that bl64_py_pip_usr_prepare was runned before
# * Uses the latest version of PIP (previously upgraded by bl64_py_pip_usr_prepare)
#
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   n: package manager exit status
#######################################
function bl64_py_pip_usr_install() {
  bl64_dbg_lib_show_function "$@"
  local flag_user="$BL64_PY_SET_PIP_USER"

  bl64_check_parameters_none $# || return $?

  # If venv is in use no need to flag usr install
  [[ -n "$VIRTUAL_ENV" ]] && flag_user=' '

  bl64_msg_show_lib_task "$_BL64_PY_TXT_PIP_INSTALL ($*)"
  # shellcheck disable=SC2086
  bl64_py_run_pip \
    'install' \
    $BL64_PY_SET_PIP_UPGRADE \
    $BL64_PY_SET_PIP_NO_WARN_SCRIPT \
    $flag_user \
    "$@"
}

#######################################
# Deploy PIP packages
#
# * Before installation: prepares the package manager environment and cache
# * After installation: removes cache and temporary files
#
# Arguments:
#   package list, separated by spaces (expanded with $@)
# Outputs:
#   STDOUT: process output
#   STDERR: process stderr
# Returns:
#   n: process exist status
#######################################
function bl64_py_pip_usr_deploy() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none $# || return $?

  bl64_py_pip_usr_prepare &&
    bl64_py_pip_usr_install "$@" ||
    return $?

  bl64_py_pip_usr_cleanup
  return 0
}

#######################################
# Clean up pip install environment
#
# * Empty cache
# * Ignore errors and warnings
# * Best effort
#
# Arguments:
#   None
# Outputs:
#   STDOUT: package manager stderr
#   STDERR: package manager stderr
# Returns:
#   0: always ok
#######################################
function bl64_py_pip_usr_cleanup() {
  bl64_dbg_lib_show_function

  bl64_msg_show_lib_task "$_BL64_PY_TXT_PIP_CLEANUP_PIP"
  bl64_py_run_pip \
    'cache' \
    'purge'

  return 0
}

#######################################
# Python wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_py_run_python() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_PY_MODULE" ||
    return $?

  bl64_py_blank_python

  bl64_dbg_lib_trace_start
  "$BL64_PY_CMD_PYTHON3" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_py_blank_python() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited PYTHON* shell variables'
  bl64_dbg_lib_trace_start
  unset PYTHONHOME
  unset PYTHONPATH
  unset PYTHONSTARTUP
  unset PYTHONDEBUG
  unset PYTHONUSERBASE
  unset PYTHONEXECUTABLE
  unset PYTHONWARNINGS
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Python PIP wrapper
#
# * Uses global ephemeral settings when configured for temporal and cache
#
# Arguments:
#   $@: arguments are passes as-is
# Outputs:
#   STDOUT: PIP output
#   STDERR: PIP error
# Returns:
#   PIP exit status
#######################################
function bl64_py_run_pip() {
  bl64_dbg_lib_show_function "$@"
  local debug="$BL64_PY_SET_PIP_QUIET"
  local temporal=' '
  local cache=' '

  bl64_msg_lib_verbose_enabled && debug=' '
  bl64_dbg_lib_command_enabled && debug="$BL64_PY_SET_PIP_DEBUG"

  [[ -n "$BL64_FS_PATH_TEMPORAL" ]] && temporal="TMPDIR=${BL64_FS_PATH_TEMPORAL}"
  [[ -n "$BL64_FS_PATH_CACHE" ]] && cache="--cache-dir=${BL64_FS_PATH_CACHE}"

  # shellcheck disable=SC2086
  eval $temporal bl64_py_run_python \
    -m "$BL64_PY_DEF_MODULE_PIP" \
    $debug \
    $cache \
    "$*"
}

#######################################
# BashLib64 / Module / Setup / Manage role based access service
#
# Version: 1.2.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_rbac_setup() {
  bl64_dbg_lib_show_function

  bl64_rbac_set_command &&
    bl64_rbac_set_alias &&
    BL64_RBAC_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_rbac_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-* | ${BL64_OS_MCOS}-*)
    BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
    BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
    BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_rbac_set_alias() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-* | ${BL64_OS_MCOS}-*)
    BL64_RBAC_ALIAS_SUDO_ENV="$BL64_RBAC_CMD_SUDO --preserve-env --set-home"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Manage role based access service
#
# Version: 1.10.1
#######################################

#######################################
# Add password-less root privilege
#
# Arguments:
#   $1: user name. User must already be present.
# Outputs:
#   STDOUT: None
#   STDERR: execution errors
# Returns:
#   0: rule added
#   >0: failed command exit status
#######################################
function bl64_rbac_add_root() {
  bl64_dbg_lib_show_function "$@"
  local user="$1"
  local new_sudoers="${BL64_RBAC_FILE_SUDOERS}.bl64_new"
  local old_sudoers="${BL64_RBAC_FILE_SUDOERS}.bl64_old"
  local -i status=0

  bl64_check_privilege_root &&
    bl64_check_parameter 'user' &&
    bl64_check_file "$BL64_RBAC_FILE_SUDOERS" &&
    bl64_rbac_check_sudoers "$BL64_RBAC_FILE_SUDOERS" ||
    return $?

  bl64_msg_show_lib_task "$_BL64_RBAC_TXT_ADD_ROOT ($user)"
  umask 0266
  # shellcheck disable=SC2016
  bl64_txt_run_awk \
    -v ControlUsr="$user" \
    '
      BEGIN { Found = 0 }
      ControlUsr " ALL=(ALL) NOPASSWD: ALL" == $0 { Found = 1 }
      { print $0 }
      END {
        if( Found == 0) {
          print( ControlUsr " ALL=(ALL) NOPASSWD: ALL" )
        }
      }
    ' \
    "$BL64_RBAC_FILE_SUDOERS" >"$new_sudoers"

  if [[ -s "$new_sudoers" ]]; then
    bl64_fs_cp_file "${BL64_RBAC_FILE_SUDOERS}" "$old_sudoers"
  fi
  if [[ -s "$new_sudoers" && -s "$old_sudoers" ]]; then
    "$BL64_OS_CMD_CAT" "${BL64_RBAC_FILE_SUDOERS}.bl64_new" >"${BL64_RBAC_FILE_SUDOERS}" &&
      bl64_rbac_check_sudoers "$BL64_RBAC_FILE_SUDOERS"
    status=$?
  else
    status=$BL64_LIB_ERROR_TASK_FAILED
  fi

  # shellcheck disable=SC2086
  return $status
}

#######################################
# Use visudo --check to validate sudoers file
#
# Arguments:
#   $1: full path to the sudoers file
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: sudoers sintax ok
#   visudo exit status
#######################################
function bl64_rbac_check_sudoers() {
  bl64_dbg_lib_show_function "$@"
  local sudoers="$1"
  local -i status=0
  local debug='--quiet'

  bl64_check_parameter 'sudoers' &&
    bl64_check_command "$BL64_RBAC_CMD_VISUDO" ||
    return $?

  bl64_dbg_lib_command_enabled && debug=' '

  # shellcheck disable=SC2086
  "$BL64_RBAC_CMD_VISUDO" \
    $debug \
    --check \
    --file="$sudoers"
  status=$?

  if ((status != 0)); then
    bl64_msg_show_error "$_BL64_RBAC_TXT_INVALID_SUDOERS ($sudoers)"
  fi

  return $status
}

#######################################
# Run privileged OS command using Sudo if needed
#
# Arguments:
#   $1: user to run as. Default: root
#   $@: command and arguments to run
# Outputs:
#   STDOUT: command or sudo output
#   STDERR: command or sudo error
# Returns:
#   command or sudo exit status
#######################################
function bl64_rbac_run_command() {
  bl64_dbg_lib_show_function "$@"
  local user="${1:-${BL64_LIB_VAR_NULL}}"
  local target=''

  bl64_check_parameter 'user' &&
    bl64_check_command "$BL64_RBAC_CMD_SUDO" ||
    return $?

  shift
  bl64_check_parameters_none "$#" ||
    return $?
  target="$(bl64_iam_user_get_id "${user}")" || return $?

  if [[ "$UID" == "$target" ]]; then
    bl64_dbg_lib_show_info "run command directly (user: $user)"
    bl64_dbg_lib_trace_start
    "$@"
    bl64_dbg_lib_trace_stop
  else
    bl64_dbg_lib_show_info "run command with sudo (user: $user)"
    bl64_dbg_lib_trace_start
    $BL64_RBAC_ALIAS_SUDO_ENV -u "$user" "$@"
    bl64_dbg_lib_trace_stop
  fi
}

#######################################
# Run privileged Bash function using Sudo if needed
#
# Arguments:
#   $1: library that contains the target function.
#   $2: user to run as. Default: root
#   $@: command and arguments to run
# Outputs:
#   STDOUT: command or sudo output
#   STDERR: command or sudo error
# Returns:
#   command or sudo exit status
#######################################
function bl64_rbac_run_bash_function() {
  bl64_dbg_lib_show_function "$@"
  local library="${1:-${BL64_LIB_VAR_NULL}}"
  local user="${2:-${BL64_LIB_VAR_NULL}}"
  local target=''

  bl64_check_parameter 'library' &&
    bl64_check_parameter 'user' &&
    bl64_check_file "$library" &&
    bl64_check_command "$BL64_RBAC_CMD_SUDO" ||
    return $?

  shift
  shift
  bl64_check_parameters_none "$#" ||
    return $?

  target="$(bl64_iam_user_get_id "${user}")" || return $?

  if [[ "$UID" == "$target" ]]; then
    # shellcheck disable=SC1090
    . "$library" &&
      "$@"
  else
    bl64_dbg_lib_trace_start
    $BL64_RBAC_ALIAS_SUDO_ENV -u "$user" "$BL64_OS_CMD_BASH" -c ". ${library}; ${*}"
    bl64_dbg_lib_trace_stop
  fi
}

#######################################
# BashLib64 / Module / Functions / Generate random data
#
# Version: 1.1.0
#######################################

#######################################
# Generate random integer number between min and max
#
# Arguments:
#   $1: Minimum. Default: BL64_RND_RANDOM_MIN
#   $2: Maximum. Default: BL64_RND_RANDOM_MAX
# Outputs:
#   STDOUT: random number
#   STDERR: execution error
# Returns:
#   0: no error
#   >0: printf error
#   BL64_LIB_ERROR_PARAMETER_RANGE
#   BL64_LIB_ERROR_PARAMETER_RANGE
#######################################
function bl64_rnd_get_range() {
  bl64_dbg_lib_show_function "$@"
  local min="${1:-${BL64_RND_RANDOM_MIN}}"
  local max="${2:-${BL64_RND_RANDOM_MAX}}"
  local modulo=0

  # shellcheck disable=SC2086
  ((min < BL64_RND_RANDOM_MIN)) &&
    bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MIN $BL64_RND_RANDOM_MIN" && return $BL64_LIB_ERROR_PARAMETER_RANGE
  # shellcheck disable=SC2086
  ((max > BL64_RND_RANDOM_MAX)) &&
    bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MAX $BL64_RND_RANDOM_MAX" && return $BL64_LIB_ERROR_PARAMETER_RANGE

  modulo=$((max - min + 1))

  printf '%s' "$((min + (RANDOM % modulo)))"
}

#######################################
# Generate numeric string
#
# Arguments:
#   $1: Length. Default: BL64_RND_LENGTH_1
# Outputs:
#   STDOUT: random string
#   STDERR: execution error
# Returns:
#   0: no error
#   >0: printf error
#   BL64_LIB_ERROR_PARAMETER_RANGE
#   BL64_LIB_ERROR_PARAMETER_RANGE
#######################################
function bl64_rnd_get_numeric() {
  bl64_dbg_lib_show_function "$@"
  local length="${1:-${BL64_RND_LENGTH_1}}"
  local seed=''

  # shellcheck disable=SC2086
  ((length < BL64_RND_LENGTH_1)) &&
    bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MIN $BL64_RND_LENGTH_1" && return $BL64_LIB_ERROR_PARAMETER_RANGE
  # shellcheck disable=SC2086
  ((length > BL64_RND_LENGTH_20)) &&
    bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MAX $BL64_RND_LENGTH_20" && return $BL64_LIB_ERROR_PARAMETER_RANGE

  seed="${RANDOM}${RANDOM}${RANDOM}${RANDOM}${RANDOM}"
  printf '%s' "${seed:0:$length}"
}

#######################################
# Generate alphanumeric string
#
# Arguments:
#   $1: Minimum. Default: BL64_RND_RANDOM_MIN
#   $2: Maximum. Default: BL64_RND_RANDOM_MAX
# Outputs:
#   STDOUT: random string
#   STDERR: execution error
# Returns:
#   0: no error
#   >0: printf error
#   BL64_LIB_ERROR_PARAMETER_RANGE
#   BL64_LIB_ERROR_PARAMETER_RANGE
#######################################
function bl64_rnd_get_alphanumeric() {
  bl64_dbg_lib_show_function "$@"
  local length="${1:-${BL64_RND_LENGTH_1}}"
  local output=''
  local item=''
  local index=0
  local count=0

  ((length < BL64_RND_LENGTH_1)) &&
    bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MIN $BL64_RND_LENGTH_1" && return $BL64_LIB_ERROR_PARAMETER_RANGE
  ((length > BL64_RND_LENGTH_100)) &&
    bl64_msg_show_error "$_BL64_RND_TXT_LENGHT_MAX $BL64_RND_LENGTH_100" && return $BL64_LIB_ERROR_PARAMETER_RANGE

  while ((count < length)); do
    index=$(bl64_rnd_get_range '0' "$BL64_RND_POOL_ALPHANUMERIC_MAX_IDX")
    item="$(printf '%s' "${BL64_RND_POOL_ALPHANUMERIC:$index:1}")"
    output="${output}${item}"
    ((count++))
  done

  printf '%s' "$output"
}

#######################################
# BashLib64 / Module / Setup / Transfer and Receive data over the network
#
# Version: 1.2.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_rxtx_setup() {
  bl64_dbg_lib_show_function

  bl64_rxtx_set_command &&
    bl64_rxtx_set_alias &&
    bl64_rxtx_set_options &&
    BL64_RXTX_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_rxtx_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET="$BL64_LIB_INCOMPATIBLE"
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_rxtx_set_options() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-11.* | ${BL64_OS_FD}-*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent --no-progress-meter'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    ;;
  ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_DEB}-9.* | ${BL64_OS_DEB}-10.*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='-O'
    BL64_RXTX_SET_WGET_SECURE=' '
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent --no-progress-meter'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE=''
    BL64_RXTX_SET_WGET_OUTPUT=''
    BL64_RXTX_SET_WGET_SECURE=''
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command aliases for common use cases
#
# * Aliases are presented as regular shell variables for easy inclusion in complex commands
# * Use the alias without quotes, otherwise the shell will interprete spaces as part of the command
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_rxtx_set_alias() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET=''
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# BashLib64 / Module / Functions / Transfer and Receive data over the network
#
# Version: 1.14.0
#######################################

#######################################
# Pull data from web server
#
# * If the destination is already present no update is done unless $3=$BL64_LIB_VAR_ON
#
# Arguments:
#   $1: Source URL
#   $2: Full path to the destination file
#   $3: replace existing content Values: $BL64_LIB_VAR_ON | $BL64_LIB_VAR_OFF (default)
#   $4: permissions. Regular chown format accepted. Default: umask defined
# Outputs:
#   STDOUT: None unless BL64_DBG_TARGET_LIB_CMD
#   STDERR: command error
# Returns:
#   BL64_LIB_ERROR_APP_MISSING
#   command error status
#######################################
function bl64_rxtx_web_get_file() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"
  local destination="$2"
  local replace="${3:-${BL64_LIB_VAR_OFF}}"
  local mode="${4:-${BL64_LIB_DEFAULT}}"
  local -i status=0

  bl64_check_module_setup "$BL64_RXTX_MODULE" &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' || return $?

  [[ "$replace" == "$BL64_LIB_VAR_OFF" && -e "$destination" ]] &&
    bl64_dbg_lib_show_info "destination is already created (${destination}) and overwrite is disabled. No action taken" &&
    return 0
  bl64_fs_safeguard "$destination" >/dev/null || return $?

  bl64_msg_show_lib_task "$_BL64_RXTX_TXT_DOWNLOAD_FILE ($source)"
  # shellcheck disable=SC2086
  if [[ -x "$BL64_RXTX_CMD_CURL" ]]; then
    bl64_rxtx_run_curl \
      $BL64_RXTX_SET_CURL_REDIRECT \
      $BL64_RXTX_SET_CURL_OUTPUT "$destination" \
      "$source"
    status=$?
  elif [[ -x "$BL64_RXTX_CMD_WGET" ]]; then
    bl64_rxtx_run_wget \
      $BL64_RXTX_SET_WGET_OUTPUT "$destination" \
      "$source"
    status=$?
  else
    bl64_msg_show_error "$_BL64_RXTX_TXT_MISSING_COMMAND (wget or curl)" &&
      return $BL64_LIB_ERROR_APP_MISSING
  fi

  # Determine if mode needs to be set
  if [[ "$status" == '0' && "$mode" != "$BL64_LIB_DEFAULT" ]]; then
    bl64_fs_run_chmod "$mode" "$destination"
    status=$?
  fi

  bl64_fs_restore "$destination" "$status" || return $?

  return $status
}

#######################################
# Pull directory contents from git repo
#
# * Content of source path is downloaded into destination (source_path/* --> destionation/). Source path itself is not created
# * If the destination is already present no update is done unless $4=$BL64_LIB_VAR_ON
# * If asked to replace destination, temporary backup is done in case git fails by moving the destination to a temp name
# * Warning: git repo info is removed after pull (.git)
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: source path. Format: relative to the repo URL. Use '.' to download the full repo
#   $3: destination path. Format: full path
#   $4: replace existing content. Values: $BL64_LIB_VAR_ON | $BL64_LIB_VAR_OFF (default)
#   $5: branch name. Default: main
# Outputs:
#   STDOUT: command stdout
#   STDERR: command error
# Returns:
#   BL64_LIB_ERROR_TASK_TEMP
#   command error status
#######################################
function bl64_rxtx_git_get_dir() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local replace="${4:-${BL64_LIB_VAR_OFF}}"
  local branch="${5:-main}"
  local -i status=0

  bl64_check_module_setup "$BL64_RXTX_MODULE" &&
    bl64_check_parameter 'source_url' &&
    bl64_check_parameter 'source_path' &&
    bl64_check_parameter 'destination' &&
    bl64_check_path_relative "$source_path" ||
    return $?

  # shellcheck disable=SC2086
  bl64_check_overwrite "$destination" "$replace" "$_BL64_RXTX_TXT_EXISTING_DESTINATION" || return $BL64_LIB_VAR_OK

  # Asked to replace, backup first
  bl64_fs_safeguard "$destination" || return $?

  # Detect what type of path is requested
  if [[ "$source_path" == '.' || "$source_path" == './' ]]; then
    _bl64_rxtx_git_get_dir_root "$source_url" "$destination" "$branch"
  else
    _bl64_rxtx_git_get_dir_sub "$source_url" "$source_path" "$destination" "$branch"
  fi
  status=$?

  # Remove GIT repo metadata
  if [[ -d "${destination}/.git" ]]; then
    bl64_dbg_lib_show_info "remove git metadata (${destination}/.git)"
    # shellcheck disable=SC2164
    cd "$destination"
    bl64_fs_rm_full '.git' >/dev/null
  fi

  # Check if restore is needed
  bl64_fs_restore "$destination" "$status" || return $?
  return $status
}

#######################################
# CURL wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_rxtx_run_curl() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose="$BL64_RXTX_SET_CURL_SILENT"

  bl64_check_module_setup "$BL64_RXTX_MODULE" &&
    bl64_check_command "$BL64_RXTX_CMD_CURL" || return $?

  bl64_dbg_lib_command_enabled && verbose="$BL64_RXTX_SET_CURL_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_RXTX_CMD_CURL" \
    $BL64_RXTX_SET_CURL_SECURE \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# WGet wrapper with verbose, debug and common options
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_rxtx_run_wget() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local verbose=''

  bl64_check_module_setup "$BL64_RXTX_MODULE" &&
    bl64_check_command "$BL64_RXTX_CMD_WGET" || return $?

  bl64_dbg_lib_command_enabled && verbose="$BL64_RXTX_SET_WGET_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_RXTX_CMD_WGET" \
    $verbose \
    "$@"
  bl64_dbg_lib_trace_stop
}

function _bl64_rxtx_git_get_dir_root() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local destination="${2}"
  local branch="${3:-main}"
  local -i status=0
  local repo=''
  local git_name=''
  local transition=''

  bl64_check_module_setup "$BL64_RXTX_MODULE" || return $?

  repo="$($BL64_FS_ALIAS_MKTEMP_DIR)"
  bl64_check_directory "$repo" "$_BL64_RXTX_TXT_CREATION_PROBLEM" || return $BL64_LIB_ERROR_TASK_TEMP

  git_name="$(bl64_fmt_basename "$source_url")"
  git_name="${git_name/.git/}"
  transition="${repo}/${git_name}"
  bl64_dbg_lib_show_vars 'git_name' 'transition'

  # Clone the repo
  bl64_vcs_git_clone "$source_url" "$repo" "$branch" &&
    bl64_dbg_lib_show_info 'promote to destination' &&
    bl64_fs_run_mv "$transition" "$destination"
  status=$?

  [[ -d "$repo" ]] && bl64_fs_rm_full "$repo" >/dev/null
  return $status
}

function _bl64_rxtx_git_get_dir_sub() {
  bl64_dbg_lib_show_function "$@"
  local source_url="${1}"
  local source_path="${2}"
  local destination="${3}"
  local branch="${4:-main}"
  local -i status=0
  local repo=''
  local target=''
  local source=''
  local transition=''

  bl64_check_module_setup "$BL64_RXTX_MODULE" || return $?

  repo="$($BL64_FS_ALIAS_MKTEMP_DIR)"
  # shellcheck disable=SC2086
  bl64_check_directory "$repo" "$_BL64_RXTX_TXT_CREATION_PROBLEM" || return $BL64_LIB_ERROR_TASK_TEMP

  # Use transition path to get to the final target path
  source="${repo}/${source_path}"
  target="$(bl64_fmt_basename "$destination")"
  transition="${repo}/transition/${target}"
  bl64_dbg_lib_show_vars 'source' 'target' 'transition'

  bl64_vcs_git_sparse "$source_url" "$repo" "$branch" "$source_path" &&
    [[ -d "$source" ]] &&
    bl64_fs_mkdir_full "${repo}/transition" &&
    bl64_fs_run_mv "$source" "$transition" >/dev/null &&
    bl64_fs_run_mv "${transition}" "$destination" >/dev/null
  status=$?

  [[ -d "$repo" ]] && bl64_fs_rm_full "$repo" >/dev/null
  return $status
}

#######################################
# BashLib64 / Module / Functions / Manage date-time data
#
# Version: 1.0.0
#######################################

#######################################
# Get current date-time in timestamp format
#
# * Format: DDMMYYHHMMSS
#
# Arguments:
#   None
# Outputs:
#   STDOUT: formated string
#   STDERR: command Error message
# Returns:
#   date exit status
#######################################
function bl64_tm_create_timestamp() {
  "$BL64_OS_CMD_DATE" '+%d%m%Y%H%M%S'
}

#######################################
# Get current date-time in file timestamp format
#
# * Format: DD:MM:YYYY-HH:MM:SS-TZ
#
# Arguments:
#   None
# Outputs:
#   STDOUT: formated string
#   STDERR: command Error message
# Returns:
#   date exit status
#######################################
function bl64_tm_create_timestamp_file() {
  "$BL64_OS_CMD_DATE" '+%d:%m:%Y-%H:%M:%S-UTC%z'
}

#######################################
# BashLib64 / Module / Setup / Manipulate text files content
#
# Version: 1.4.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_txt_setup() {
  bl64_dbg_lib_show_function

  bl64_txt_set_command &&
    bl64_txt_set_options &&
    BL64_TXT_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok, even when the OS is not supported
#######################################
# Warning: bootstrap function
function bl64_txt_set_command() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/bin/grep'
    BL64_TXT_CMD_SED='/bin/sed'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/bin/grep'
    BL64_TXT_CMD_SED='/bin/sed'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_BASE64='/bin/base64'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_GAWK="$BL64_LIB_INCOMPATIBLE"
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_ENVSUBST='/opt/homebrew/bin/envsubst'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_txt_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac

}

#######################################
# BashLib64 / Module / Functions / Manipulate text files content
#
# Version: 1.5.0
#######################################

#######################################
# Read a text file, replace shell variable names with its value and show the result on stdout
#
# * Uses envsubst
# * Variables in the source file must follow the syntax: $VARIABLE or ${VARIABLE}
#
# Arguments:
#   $1: source file path
# Outputs:
#   STDOUT: source modified with replaced variables
#   STDERR: command stderr
# Returns:
#   0: replacement ok
#   >0: status from last failed command
#######################################
function bl64_txt_replace_env() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:-}"

  bl64_check_parameter 'source' &&
    bl64_check_file "$source" ||
    return $?

  bl64_txt_run_envsubst <"$source"
}

#######################################
# Search for a whole line in a given text file
#
# Arguments:
#   $1: source file path
#   $2: text to look for
# Outputs:
#   STDOUT: none
#   STDERR: Error messages
# Returns:
#   0: line was found
#   >0: grep command exit status
#######################################
function bl64_txt_search_line() {
  bl64_dbg_lib_show_function "$@"
  local source="${1:--}"
  local line="${2:-}"

  "$BL64_TXT_CMD_GREP" "$BL64_TXT_SET_GREP_ERE" "^${line}$" "$source" >/dev/null
}

#######################################
# OS command wrapper: awk
#
# * Detects OS provided awk and selects the best match
# * The selected awk app is configured for POSIX compatibility and traditional regexp
# * If gawk is required use the BL64_TXT_CMD_GAWK variable instead of this function
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_txt_run_awk() {
  bl64_dbg_lib_show_function "$@"
  bl64_check_parameters_none "$#" || return $?
  local awk_cmd="$BL64_LIB_INCOMPATIBLE"
  local awk_flags=' '

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    if [[ -x '/usr/bin/gawk' ]]; then
      awk_cmd='/usr/bin/gawk'
      awk_flags='--posix'
    elif [[ -x '/usr/bin/mawk' ]]; then
      awk_cmd='/usr/bin/mawk'
    fi
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    awk_cmd='/usr/bin/gawk'
    awk_flags='--posix'
    ;;
  ${BL64_OS_ALP}-*)
    if [[ -x '/usr/bin/gawk' ]]; then
      awk_cmd='/usr/bin/gawk'
      awk_flags='--posix'
    fi
    ;;
  ${BL64_OS_MCOS}-*)
    awk_cmd='/usr/bin/awk'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
  bl64_check_command "$awk_cmd" || return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$awk_cmd" $awk_flags "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
# shellcheck disable=SC2120
function bl64_txt_run_envsubst() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module_setup "$BL64_TXT_MODULE" &&
    bl64_check_command "$BL64_TXT_CMD_ENVSUBST" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_ENVSUBST" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_txt_run_grep() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_TXT_MODULE" &&
    bl64_check_command "$BL64_TXT_CMD_GREP" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_GREP" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_txt_run_sed() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_TXT_MODULE" &&
    bl64_check_command "$BL64_TXT_CMD_SED" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_SED" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_txt_run_base64() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_module_setup "$BL64_TXT_MODULE" &&
    bl64_check_command "$BL64_TXT_CMD_BASE64" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_BASE64" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_txt_run_tr() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_TXT_MODULE" &&
    bl64_check_command "$BL64_TXT_CMD_TR" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_TR" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Command wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_txt_run_cut() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module_setup "$BL64_TXT_MODULE" &&
    bl64_check_command "$BL64_TXT_CMD_CUT" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_CUT" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# BashLib64 / Module / Setup / User Interface
#
# Version: 1.0.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_ui_setup() {
  bl64_dbg_lib_show_function

  BL64_UI_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# BashLib64 / Module / Functions / User Interface
#
# Version: 1.0.0
#######################################

#######################################
# Ask for confirmation
#
# * Use to confirm dangerous operations
#
# Arguments:
#   $1: confirmation question
#   $2: confirmation value that needs to be match
# Outputs:
#   STDOUT: user interaction
#   STDERR: command stderr
# Returns:
#   0: confirmed
#   >0: not confirmed
#######################################
function bl64_ui_ask_confirmation() {
  local question="${1:-${_BL64_UI_TXT_CONFIRMATION_QUESTION}}"
  local confirmation="${2:-${_BL64_UI_TXT_CONFIRMATION_MESSAGE}}"
  local input=''

  bl64_msg_show_input "${question} [${confirmation}]: "
  read -r -t "$BL64_UI_READ_TIMEOUT" input

  if [[ "$input" != "$confirmation" ]]; then
    bl64_msg_show_error "$_BL64_UI_TXT_CONFIRMATION_ERROR"
    return $BL64_LIB_ERROR_PARAMETER_INVALID
  fi

  return 0
}

#######################################
# BashLib64 / Module / Setup / Manage Version Control System
#
# Version: 2.0.0
#######################################

#######################################
# Setup the bashlib64 module
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: setup ok
#   >0: setup failed
#######################################
function bl64_vcs_setup() {
  bl64_dbg_lib_show_function

  bl64_vcs_set_command &&
    bl64_vcs_set_options &&
    BL64_VCS_MODULE="$BL64_LIB_VAR_ON"

}

#######################################
# Identify and normalize commands
#
# * Commands are exported as variables with full path
# * The caller function is responsible for checking that the target command is present (installed)
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_vcs_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-* | ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-* | ${BL64_OS_ALP}-* | ${BL64_OS_MCOS}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac
}

#######################################
# Create command sets for common options
#
# * Warning: bootstrap function
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_vcs_set_options() {
  bl64_dbg_lib_show_function
  # Common sets - unversioned
  BL64_VCS_SET_GIT_NO_PAGER='--no-pager'
  BL64_VCS_SET_GIT_QUIET=' '
}

#######################################
# BashLib64 / Module / Functions / Manage Version Control System
#
# Version: 1.10.0
#######################################

#######################################
# GIT CLI wrapper with verbose, debug and common options
#
# * Trust no one. Ignore inherited config and use explicit config
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_vcs_run_git() {
  bl64_dbg_lib_show_function "$@"
  local debug="$BL64_VCS_SET_GIT_QUIET"

  bl64_check_parameters_none "$#" &&
    bl64_check_command "$BL64_VCS_CMD_GIT" || return $?

  bl64_vcs_blank_git

  bl64_dbg_lib_show_info "current path: $(pwd)"
  if bl64_dbg_lib_command_enabled; then
    debug=''
    export GIT_TRACE='2'
  else
    export GIT_TRACE='0'
  fi

  export GIT_CONFIG_NOSYSTEM='0'
  export GIT_AUTHOR_EMAIL='nouser@nodomain'
  export GIT_AUTHOR_NAME='bl64_vcs_run_git'

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_VCS_CMD_GIT" \
    $debug \
    $BL64_VCS_SET_GIT_NO_PAGER \
    "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Remove or nullify inherited shell variables that affects command execution
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function bl64_vcs_blank_git() {
  bl64_dbg_lib_show_function

  bl64_dbg_lib_show_info 'unset inherited GIT_* shell variables'
  bl64_dbg_lib_trace_start
  unset GIT_TRACE
  unset GIT_CONFIG_NOSYSTEM
  unset GIT_AUTHOR_EMAIL
  unset GIT_AUTHOR_NAME
  bl64_dbg_lib_trace_stop

  return 0
}

#######################################
# Clone GIT branch
#
# * File ownership is set to the current user
# * Destination is created if not existing
# * Single branch
# * Depth = 1
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: destination path where the repository will be created
#   $3: branch name. Default: main
# Outputs:
#   STDOUT: git output
#   STDERR: git stderr
# Returns:
#   n: git exit status
#######################################
function bl64_vcs_git_clone() {
  bl64_dbg_lib_show_function "$@"
  local source="${1}"
  local destination="${2}"
  local branch="${3:-main}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_command "$BL64_VCS_CMD_GIT" ||
    return $?

  bl64_fs_create_dir "${BL64_LIB_DEFAULT}" "${BL64_LIB_DEFAULT}" "${BL64_LIB_DEFAULT}" "$destination" || return $?

  bl64_msg_show_lib_task "$_BL64_VCS_TXT_CLONE_REPO ($source)"

  # shellcheck disable=SC2164
  cd "$destination"

  # shellcheck disable=SC2086
  bl64_vcs_run_git \
    clone \
    --depth 1 \
    --single-branch \
    --branch "$branch" \
    "$source"
}

#######################################
# Clone partial GIT repository (sparse checkout)
#
# * File ownership is set to the current user
# * Destination is created if not existing
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: destination path where the repository will be created
#   $3: branch name. Default: main
#   $4: include pattern list. Field separator: space
# Outputs:
#   STDOUT: git output
#   STDERR: git stderr
# Returns:
#   n: git exit status
#######################################
function bl64_vcs_git_sparse() {
  bl64_dbg_lib_show_function "$@"
  local source="${1}"
  local destination="${2}"
  local branch="${3:-main}"
  local pattern="${4}"
  local item=''
  local -i status=0

  bl64_check_command "$BL64_VCS_CMD_GIT" &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' &&
    bl64_check_parameter 'pattern' || return $?

  bl64_fs_create_dir "${BL64_LIB_DEFAULT}" "${BL64_LIB_DEFAULT}" "${BL64_LIB_DEFAULT}" "$destination" || returnn $?

  # shellcheck disable=SC2164
  cd "$destination"

  if bl64_os_match 'DEB-9' 'DEB-10' 'UB-20' 'OL-7' 'CNT-7'; then
    # shellcheck disable=SC2086
    bl64_vcs_run_git init &&
      bl64_vcs_run_git remote add origin "$source" &&
      bl64_vcs_run_git config core.sparseCheckout true &&
      {
        IFS=' '
        for item in $pattern; do echo "$item" >>'.git/info/sparse-checkout'; done
        unset IFS
      } &&
      bl64_vcs_run_git pull --depth 1 origin "$branch"
  else
    # shellcheck disable=SC2086
    bl64_vcs_run_git init &&
      bl64_vcs_run_git sparse-checkout set &&
      {
        IFS=' '
        for item in $pattern; do echo "$item"; done | bl64_vcs_run_git sparse-checkout add --stdin
      } &&
      bl64_vcs_run_git remote add origin "$source" &&
      bl64_vcs_run_git pull --depth 1 origin "$branch"
  fi
  status=$?

  return $status
}

#######################################
# BashLib64 / Module / Functions / Manipulate CSV like text files
#
# Version: 1.4.0
#######################################

#######################################
# Dump file to STDOUT without comments and spaces
#
# Arguments:
#   $1: Full path to the file
# Outputs:
#   STDOUT: file content
#   STDERR: Error messages
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_FILE_*
#######################################
function bl64_xsv_dump() {
  bl64_dbg_lib_show_function "$@"
  local source="$1"

  bl64_check_parameter 'source' &&
    bl64_check_file "$source" "$_BL64_XSV_TXT_SOURCE_NOT_FOUND" || return $?

  "$BL64_TXT_CMD_GREP" "$BL64_TXT_SET_GREP_INVERT" "$BL64_TXT_SET_GREP_ERE" '^#.*$|^$' "$source"

}

#######################################
# Search for records based on key filters and return matching rows
#
# * Column numbers are AWK fields. First column: 1
#
# Arguments:
#   $1: Single string with one ore more search values separated by $BL64_XSV_FS
#   $2: source file path. Default: STDIN
#   $3: one ore more column numbers (keys) where values will be searched. Format: single string using $BL64_XSV_COLON as field separator
#   $4: one or more fields to show on record match. Format: single string using $BL64_XSV_COLON as field separator
#   $5: field separator for the source file. Default: $BL64_XSV_COLON
#   $6: field separator for the output record. Default: $BL64_XSV_COLON
# Outputs:
#   STDOUT: matching records
#   STDERR: Error messages
# Returns:
#   0: successfull execution
#   >0: awk command exit status
#######################################
function bl64_xsv_search_records() {
  bl64_dbg_lib_show_function "$@"
  local values="$1"
  local source="${2:--}"
  local keys="${3:-1}"
  local fields="${4:-0}"
  local fs_src="${5:-$BL64_XSV_FS_COLON}"
  local fs_out="${6:-$BL64_XSV_FS_COLON}"

  # shellcheck disable=SC2086
  bl64_check_parameter 'values' 'search value' || return $?

  # shellcheck disable=SC2016
  bl64_txt_run_awk \
    -F "$fs_src" \
    -v VALUES="${values}" \
    -v KEYS="$keys" \
    -v FIELDS="$fields" \
    -v FS_OUT="$fs_out" \
    '
      BEGIN {
        show_total = split( FIELDS, show_fields, ENVIRON["BL64_XSV_FS_COLON"] )
        keys_total = split( KEYS, keys_fields, ENVIRON["BL64_XSV_FS_COLON"] )
        values_total = split( VALUES, values_fields, ENVIRON["BL64_XSV_FS"] )
        if( keys_total != values_total ) {
          exit ENVIRON["BL64_LIB_ERROR_PARAMETER_INVALID"]
        }
        row_match = ""
        count = 0
        found = 0
      }
      /^#/ || /^$/ { next }
      {
        found = 0
        for( count = 1; count <= keys_total; count++ ) {
          if ( $keys_fields[count] == values_fields[count] ) {
            found = 1
          } else {
            found = 0
            break
          }
        }

        if( found == 1 ) {
          row_match = $show_fields[1]
          for( count = 2; count <= show_total; count++ ) {
            row_match = row_match FS_OUT $show_fields[count]
          }
          print row_match
        }
      }
      END {}
    ' \
    "$source"

}

#######################################
# BashLib64 / Module / Functions / Setup script run-time environment
#
# Version: 3.1.0
#######################################

#
# Main
#

# Normalize locales to C
if [[ "$BL64_LIB_LANG" == '1' ]]; then
  LANG='C'
  LC_ALL='C'
  LANGUAGE='C'
fi

# Set strict mode for enhanced security
if [[ "$BL64_LIB_STRICT" == '1' ]]; then
  set -o 'nounset'
  set -o 'privileged'
fi

# Initialize mandatory modules
bl64_dbg_setup &&
  bl64_msg_setup &&
  bl64_bsh_setup &&
  bl64_os_setup &&
  bl64_txt_setup &&
  bl64_fs_setup &&
  bl64_arc_setup &&
  bl64_iam_setup &&
  bl64_pkg_setup &&
  bl64_rbac_setup &&
  bl64_ui_setup &&
  bl64_vcs_setup &&
  bl64_rxtx_setup ||
  return $?

# Set signal handlers
# shellcheck disable=SC2064
if [[ "$BL64_LIB_TRAPS" == "$BL64_LIB_VAR_ON" ]]; then
  bl64_dbg_lib_show_info 'enable traps'
  trap "$BL64_LIB_SIGNAL_HUP" 'SIGHUP'
  trap "$BL64_LIB_SIGNAL_STOP" 'SIGINT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGQUIT'
  trap "$BL64_LIB_SIGNAL_QUIT" 'SIGTERM'
  trap "$BL64_LIB_SIGNAL_DEBUG" 'DEBUG'
  trap "$BL64_LIB_SIGNAL_EXIT" 'EXIT'
  trap "$BL64_LIB_SIGNAL_ERR" 'ERR'
fi

# Set default umask
bl64_fs_set_umask

# Set script identity
bl64_bsh_script_set_identity

# Enable command mode: the library can be used as a stand-alone script to run embeded functions
if [[ "$BL64_LIB_CMD" == "$BL64_LIB_VAR_ON" ]]; then
  bl64_dbg_lib_show_info 'run bashlib64 in command mode'
  "$@"
else
  bl64_dbg_lib_show_info 'run bashlib64 in source mode'
  :
fi


#!/usr/bin/env bash
#######################################
# BashLib64 / Bash automation librbary
#
# Author: serdigital64 (https://github.com/serdigital64)
# Repository: https://github.com/serdigital64/bashlib64
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
#######################################

export BL64_VERSION='12.4.0'

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
export BL64_VAR_DEFAULT='_'

# Flag for incompatible command or task
export BL64_VAR_INCOMPATIBLE='_INC_'

# Flag for unavailable command or task
export BL64_VAR_UNAVAILABLE='_UNV_'

# Pseudo null value
export BL64_VAR_NULL='__'

# Logical values
export BL64_VAR_TRUE='0'
export BL64_VAR_FALSE='1'
export BL64_VAR_ON='1'
export BL64_VAR_OFF='0'
export BL64_VAR_OK='0'
export BL64_VAR_NONE='0'
export BL64_VAR_ALL='1'

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
# BashLib64 / Module / Globals / Interact with Bash shell
#######################################

export BL64_BSH_VERSION='1.1.2'

export BL64_BSH_MODULE="$BL64_VAR_OFF"

export BL64_BSH_VERSION_BASH=''

export _BL64_BSH_TXT_UNSUPPORTED='BashLib64 is not supported in the current Bash version'

#######################################
# BashLib64 / Module / Globals / Check for conditions and report status
#######################################

export BL64_CHECK_VERSION='3.2.0'

export BL64_CHECK_MODULE="$BL64_VAR_OFF"

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
export _BL64_CHECK_TXT_MODULE='module'

export _BL64_CHECK_TXT_USER_NOT_FOUND='required user is not present in the operating system'

export _BL64_CHECK_TXT_STATUS_ERROR='task execution failed'

export _BL64_CHECK_TXT_MODULE_SET='required bashlib64 module was not imported. Please source the module before using it'
export _BL64_CHECK_TXT_MODULE_SETUP_FAILED='failed to setup the requested bashlib64 module'
export _BL64_CHECK_TXT_MODULE_NOT_SETUP='required bashlib64 module is not setup. Call the bl64_<MODULE>_setup function before using the module'

export _BL64_CHECK_TXT_RESOURCE_NOT_FOUND='required resource was not found on the system'

#######################################
# BashLib64 / Module / Globals / Show shell debugging information
#######################################

export BL64_DBG_VERSION='2.1.0'

export BL64_DBG_MODULE="$BL64_VAR_OFF"

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

export BL64_DBG_TARGET_NONE='NONE'
export BL64_DBG_TARGET_APP_TRACE='APP_TRACE'
export BL64_DBG_TARGET_APP_TASK='APP_TASK'
export BL64_DBG_TARGET_APP_CMD='APP_CMD'
export BL64_DBG_TARGET_APP_ALL='APP'
export BL64_DBG_TARGET_APP_CUSTOM_1='CUSTOM_1'
export BL64_DBG_TARGET_APP_CUSTOM_2='CUSTOM_2'
export BL64_DBG_TARGET_APP_CUSTOM_3='CUSTOM_3'
export BL64_DBG_TARGET_LIB_TRACE='LIB_TRACE'
export BL64_DBG_TARGET_LIB_TASK='LIB_TASK'
export BL64_DBG_TARGET_LIB_CMD='LIB_CMD'
export BL64_DBG_TARGET_LIB_ALL='LIB'
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
#######################################

export BL64_FS_VERSION='4.2.2'

export BL64_FS_MODULE="$BL64_VAR_OFF"

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
export BL64_FS_SET_FIND_PRINT=''
export BL64_FS_SET_FIND_RUN=''
export BL64_FS_SET_FIND_STAY=''
export BL64_FS_SET_FIND_TYPE_DIR=''
export BL64_FS_SET_FIND_TYPE_FILE=''
export BL64_FS_SET_LN_SYMBOLIC=''
export BL64_FS_SET_LN_VERBOSE=''
export BL64_FS_SET_LS_NOCOLOR=''
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

export _BL64_FS_TXT_COPY_FILE_PATH='copy file'
export _BL64_FS_TXT_CREATE_DIR_PATH='create directory'
export _BL64_FS_TXT_MERGE_ADD_SOURCE='merge content from source'
export _BL64_FS_TXT_RESTORE_OBJECT='restore original file from backup'
export _BL64_FS_TXT_SAFEGUARD_FAILED='unable to safeguard requested path'
export _BL64_FS_TXT_SAFEGUARD_OBJECT='backup original file'
export _BL64_FS_TXT_CLEANUP_CACHES='clean up OS cache contents'
export _BL64_FS_TXT_CLEANUP_LOGS='clean up OS logs'
export _BL64_FS_TXT_CLEANUP_TEMP='clean up OS temporary files'
export _BL64_FS_TXT_MERGE_DIRS='merge directories content'

#######################################
# BashLib64 / Module / Globals / Format text data
#######################################

export BL64_FMT_VERSION='1.5.0'

export BL64_FMT_MODULE="$BL64_VAR_OFF"

#######################################
# BashLib64 / Module / Globals / Display messages
#######################################

export BL64_MSG_VERSION='3.6.0'

export BL64_MSG_MODULE="$BL64_VAR_OFF"

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

export BL64_MSG_TYPE_BATCH='BATCH'
export BL64_MSG_TYPE_BATCHERR='BATCHERR'
export BL64_MSG_TYPE_BATCHOK='BATCHOK'
export BL64_MSG_TYPE_ERROR='ERROR'
export BL64_MSG_TYPE_INFO='INFO'
export BL64_MSG_TYPE_INPUT='INPUT'
export BL64_MSG_TYPE_LIBINFO='LIBINFO'
export BL64_MSG_TYPE_LIBSUBTASK='LIBSUBTASK'
export BL64_MSG_TYPE_LIBTASK='LIBTASK'
export BL64_MSG_TYPE_PHASE='PHASE'
export BL64_MSG_TYPE_SUBTASK='SUBTASK'
export BL64_MSG_TYPE_TASK='TASK'
export BL64_MSG_TYPE_WARNING='WARNING'

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

export BL64_MSG_THEME_ID_ASCII_STD='ascii-std'
export BL64_MSG_THEME_ASCII_STD_BATCH='(@)'
export BL64_MSG_THEME_ASCII_STD_BATCHERR='(@)'
export BL64_MSG_THEME_ASCII_STD_BATCHOK='(@)'
export BL64_MSG_THEME_ASCII_STD_ERROR='(!)'
export BL64_MSG_THEME_ASCII_STD_FMTCALLER=''
export BL64_MSG_THEME_ASCII_STD_FMTHOST=''
export BL64_MSG_THEME_ASCII_STD_FMTTIME=''
export BL64_MSG_THEME_ASCII_STD_INFO='(I)'
export BL64_MSG_THEME_ASCII_STD_INPUT='(?)'
export BL64_MSG_THEME_ASCII_STD_LIBINFO='(II)'
export BL64_MSG_THEME_ASCII_STD_LIBSUBTASK='(>>)'
export BL64_MSG_THEME_ASCII_STD_LIBTASK='(--)'
export BL64_MSG_THEME_ASCII_STD_PHASE='(=)'
export BL64_MSG_THEME_ASCII_STD_SUBTASK='(>)'
export BL64_MSG_THEME_ASCII_STD_TASK='(-)'
export BL64_MSG_THEME_ASCII_STD_WARNING='(*)'

export BL64_MSG_THEME_ID_ANSI_STD='ansi-std'
export BL64_MSG_THEME_ANSI_STD_BATCH='30;1;47'
export BL64_MSG_THEME_ANSI_STD_BATCHERR='5;30;41'
export BL64_MSG_THEME_ANSI_STD_BATCHOK='30;42'
export BL64_MSG_THEME_ANSI_STD_ERROR='5;37;41'
export BL64_MSG_THEME_ANSI_STD_FMTCALLER='33'
export BL64_MSG_THEME_ANSI_STD_FMTHOST='34'
export BL64_MSG_THEME_ANSI_STD_FMTTIME='36'
export BL64_MSG_THEME_ANSI_STD_INFO='36'
export BL64_MSG_THEME_ANSI_STD_INPUT='5;30;47'
export BL64_MSG_THEME_ANSI_STD_LIBINFO='1;32'
export BL64_MSG_THEME_ANSI_STD_LIBSUBTASK='1;36'
export BL64_MSG_THEME_ANSI_STD_LIBTASK='1;35'
export BL64_MSG_THEME_ANSI_STD_PHASE='7;1;36'
export BL64_MSG_THEME_ANSI_STD_SUBTASK='37'
export BL64_MSG_THEME_ANSI_STD_TASK='1;37'
export BL64_MSG_THEME_ANSI_STD_WARNING='5;37;43'

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
# Cosmetic
#

export BL64_MSG_COSMETIC_ARROW='-->'
export BL64_MSG_COSMETIC_ARROW2='==>'
export BL64_MSG_COSMETIC_PHASE_PREFIX='===['
export BL64_MSG_COSMETIC_PHASE_SUFIX=']==='
export BL64_MSG_COSMETIC_PIPE='|'

#
# Display messages
#

export _BL64_MSG_TXT_BATCH_FINISH_ERROR='finished with errors'
export _BL64_MSG_TXT_BATCH_FINISH_OK='finished successfully'
export _BL64_MSG_TXT_BATCH_START='started'
export _BL64_MSG_TXT_BATCH='Process'
export _BL64_MSG_TXT_COMMANDS='Commands'
export _BL64_MSG_TXT_ERROR='Error'
export _BL64_MSG_TXT_FLAGS='Flags'
export _BL64_MSG_TXT_INFO='Info'
export _BL64_MSG_TXT_INPUT='Input'
export _BL64_MSG_TXT_INVALID_VALUE='invalid value. Not one of'
export _BL64_MSG_TXT_PARAMETERS='Parameters'
export _BL64_MSG_TXT_PHASE='Phase'
export _BL64_MSG_TXT_SUBTASK='Subtask'
export _BL64_MSG_TXT_TASK='Task'
export _BL64_MSG_TXT_USAGE='Usage'
export _BL64_MSG_TXT_WARNING='Warning'

#######################################
# BashLib64 / Module / Globals / OS / Identify OS attributes and provide command aliases
#######################################

export BL64_OS_VERSION='3.3.0'

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

#######################################
# BashLib64 / Module / Globals / Manage role based access service
#######################################

export BL64_RBAC_VERSION='1.12.1'

export BL64_RBAC_MODULE="$BL64_VAR_OFF"

export BL64_RBAC_CMD_SUDO=''
export BL64_RBAC_CMD_VISUDO=''
export BL64_RBAC_FILE_SUDOERS=''

export BL64_RBAC_ALIAS_SUDO_ENV=''

export BL64_RBAC_SET_SUDO_CHECK=''
export BL64_RBAC_SET_SUDO_FILE=''
export BL64_RBAC_SET_SUDO_QUIET=''

export _BL64_RBAC_TXT_INVALID_SUDOERS='the sudoers file is corrupt or invalid'
export _BL64_RBAC_TXT_ADD_ROOT='add password-less root privilege to user'

#######################################
# BashLib64 / Module / Globals / Generate random data
#######################################

export BL64_RND_VERSION='1.1.0'

export BL64_RND_MODULE="$BL64_VAR_OFF"

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
#######################################

export BL64_RXTX_VERSION='1.16.1'

export BL64_RXTX_MODULE="$BL64_VAR_OFF"

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
# BashLib64 / Module / Globals / Manage date-time data
#######################################

export BL64_TM_VERSION='1.0.0'

export BL64_TM_MODULE="$BL64_VAR_OFF"

#######################################
# BashLib64 / Module / Globals / Manipulate text files content
#######################################

export BL64_TXT_VERSION='1.9.0'

export BL64_TXT_MODULE="$BL64_VAR_OFF"

export BL64_TXT_CMD_AWK_POSIX=''
export BL64_TXT_CMD_AWK=''
export BL64_TXT_CMD_BASE64=''
export BL64_TXT_CMD_CUT=''
export BL64_TXT_CMD_ENVSUBST=''
export BL64_TXT_CMD_GAWK=''
export BL64_TXT_CMD_GREP=''
export BL64_TXT_CMD_SED=''
export BL64_TXT_CMD_SORT=''
export BL64_TXT_CMD_TR=''
export BL64_TXT_CMD_UNIQ=''

export BL64_TXT_SET_AWK_POSIX=''
export BL64_TXT_SET_GREP_ERE="$BL64_VAR_UNAVAILABLE"
export BL64_TXT_SET_GREP_INVERT="$BL64_VAR_UNAVAILABLE"
export BL64_TXT_SET_GREP_NO_CASE="$BL64_VAR_UNAVAILABLE"
export BL64_TXT_SET_GREP_QUIET="$BL64_VAR_UNAVAILABLE"
export BL64_TXT_SET_GREP_SHOW_FILE_ONLY="$BL64_VAR_UNAVAILABLE"

export BL64_TXT_SET_AWS_FS="$BL64_VAR_UNAVAILABLE"

#######################################
# BashLib64 / Module / Globals / User Interface
#######################################

export BL64_UI_VERSION='1.0.1'

export BL64_UI_MODULE="$BL64_VAR_OFF"

export BL64_UI_READ_TIMEOUT='60'

export _BL64_UI_TXT_CONFIRMATION_QUESTION='Please confirm the operation by writting the message'
export _BL64_UI_TXT_CONFIRMATION_MESSAGE='confirm-operation'
export _BL64_UI_TXT_CONFIRMATION_ERROR='provided confirmation message is not what is expected'

#######################################
# BashLib64 / Module / Globals / Manage Version Control System
#######################################

export BL64_VCS_VERSION='1.11.0'

export BL64_VCS_MODULE="$BL64_VAR_OFF"

export BL64_VCS_CMD_GIT=''

export BL64_VCS_SET_GIT_NO_PAGER=''
export BL64_VCS_SET_GIT_QUIET=''

export BL64_VCS_GITHUB_API_URL='https://api.github.com'

export _BL64_VCS_TXT_CLONE_REPO='clone single branch from GIT repository'
export _BL64_VCS_TXT_GET_LATEST_RELEASE='get release tag from latest release'

#######################################
# BashLib64 / Module / Globals / Manipulate CSV like text files
#
# Version: 1.5.0
#######################################

export BL64_XSV_VERSION='1.5.0'

export BL64_XSV_MODULE="$BL64_VAR_OFF"

# Field separators
export BL64_XSV_FS='_@64@_' # Custom
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
# BashLib64 / Module / Setup / Interact with Bash shell
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

  _bl64_bsh_set_version &&
    BL64_BSH_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'bsh'
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
function _bl64_bsh_set_version() {
  bl64_dbg_lib_show_function

  case "${BASH_VERSINFO[0]}" in
  4*) BL64_BSH_VERSION_BASH='4.0' ;;
  5*) BL64_BSH_VERSION_BASH='5.0' ;;
  *)
    bl64_msg_show_error "${_BL64_BSH_TXT_UNSUPPORTED} (${BASH_VERSINFO[0]})" &&
      return $BL64_LIB_ERROR_OS_BASH_VERSION
    ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_BSH_VERSION_BASH'

  return 0
}

#######################################
# BashLib64 / Module / Functions / Interact with Bash shell
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
  local variable="${1:-${BL64_VAR_NULL}}"
  local value="${2:-}"

  bl64_check_parameter 'variable' ||
    return $?

  printf "export %s='%s'\n" "$variable" "$value"

}

#######################################
# BashLib64 / Module / Setup / Check for conditions and report status
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
function bl64_check_setup() {
  bl64_dbg_lib_show_function

  BL64_CHECK_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'check'
}

#######################################
# BashLib64 / Module / Functions / Check for conditions and report status
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

  if [[ "$path" == "$BL64_VAR_INCOMPATIBLE" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_INCOMPATIBLE} (OS: ${BL64_OS_DISTRO} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_INCOMPATIBLE
  fi

  if [[ "$path" == "$BL64_VAR_UNAVAILABLE" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_COMMAND_NOT_INSTALLED} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_APP_MISSING
  fi

  if [[ ! -e "$path" ]]; then
    bl64_msg_show_error "${message} (command: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  fi

  if [[ ! -x "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_COMMAND_NOT_EXECUTABLE} (command: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
    bl64_msg_show_error "${message} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -f "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_FILE_NOT_FILE} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_FILE_NOT_FOUND
  fi
  if [[ ! -r "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_FILE_NOT_READABLE} (file: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
    bl64_msg_show_error "${message} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
  fi
  if [[ ! -d "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_DIRECTORY_NOT_DIR} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND
  fi
  if [[ ! -r "$path" || ! -x "$path" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_DIRECTORY_NOT_READABLE} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
    bl64_msg_show_error "${message} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_MISSING} (parameter: parameter_name ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_PARAMETER_EMPTY
  fi

  if [[ ! -v "$parameter_name" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_NOT_SET} (${description} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_PARAMETER_MISSING
  fi

  if eval "[[ -z \"\${${parameter_name}}\" || \"\${${parameter_name}}\" == '${BL64_VAR_NULL}' ]]"; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_MISSING} (${description} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_PARAMETER_EMPTY
  fi

  if eval "[[ \"\${${parameter_name}}\" == '${BL64_VAR_DEFAULT}' ]]"; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_PARAMETER_DEFAULT} (${description} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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

  bl64_check_parameter 'export_name' || return $?

  if [[ ! -v "$export_name" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_EXPORT_SET} (${description} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    # shellcheck disable=SC2086
    return $BL64_LIB_ERROR_EXPORT_SET
  fi

  if eval "[[ -z \$${export_name} ]]"; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_EXPORT_EMPTY} (${description} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
    bl64_msg_show_error "${_BL64_CHECK_TXT_PATH_NOT_RELATIVE} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
    bl64_msg_show_error "${_BL64_CHECK_TXT_PATH_PRESENT} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
    bl64_msg_show_error "${_BL64_CHECK_TXT_PATH_NOT_ABSOLUTE} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
    bl64_msg_show_error "${_BL64_CHECK_TXT_PRIVILEGE_IS_NOT_ROOT} (current id: $EUID ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
  local overwrite="${2:-"$BL64_VAR_OFF"}"
  local message="${3:-${_BL64_CHECK_TXT_OVERWRITE_NOT_PERMITED}}"

  bl64_check_parameter 'path' || return $?

  if [[ "$overwrite" == "$BL64_VAR_OFF" || "$overwrite" == "$BL64_VAR_DEFAULT" ]]; then
    if [[ -e "$path" ]]; then
      bl64_msg_show_error "${message} (path: ${path} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
  local parameter="${1:-${BL64_VAR_DEFAULT}}"
  local message="${2:-${_BL64_CHECK_TXT_PARAMETER_INVALID}}"

  [[ "$parameter" == "$BL64_VAR_DEFAULT" ]] && parameter=''
  bl64_msg_show_error "${message} (${parameter:+${_BL64_CHECK_TXT_PARAMETER}: ${parameter} ${BL64_MSG_COSMETIC_PIPE} }${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
  return $BL64_LIB_ERROR_PARAMETER_INVALID
}

#######################################
# Raise unsupported platform error
#
# Arguments:
#   $1: extra error message. Added to the error detail between (). Default: none
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_OS_INCOMPATIBLE
#######################################
function bl64_check_alert_unsupported() {
  bl64_dbg_lib_show_function "$@"
  local extra="${1:-}"

  bl64_msg_show_error "${_BL64_CHECK_TXT_INCOMPATIBLE} (${extra:+${extra} ${BL64_MSG_COSMETIC_PIPE} }os: ${BL64_OS_DISTRO} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
  return $BL64_LIB_ERROR_OS_INCOMPATIBLE
}

#######################################
# Raise resource not detected error
#
# * Generic error used when a required external resource is not found on the system
# * Common use case: module setup looking for command in known locations
#
# Arguments:
#   $1: resource name. Default: none
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_APP_MISSING
#######################################
function bl64_check_alert_resource_not_found() {
  bl64_dbg_lib_show_function "$@"
  local resource="${1:-}"

  bl64_msg_show_error "${_BL64_CHECK_TXT_RESOURCE_NOT_FOUND} (${resource:+resource: ${resource} ${BL64_MSG_COSMETIC_PIPE} }os: ${BL64_OS_DISTRO} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
  return $BL64_LIB_ERROR_APP_MISSING
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

  bl64_msg_show_error "${_BL64_CHECK_TXT_UNDEFINED} (${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE}${target:+ ${BL64_MSG_COSMETIC_PIPE} command: ${target}})"
  return $BL64_LIB_ERROR_TASK_UNDEFINED
}

#######################################
# Raise module setup error
#
# * Helper to check if the module was correctly setup and raise error if not
# * Use as last function of bl64_*_setup
# * Will take the last exit status
#
# Arguments:
#   $1: bashlib64 module alias
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   $status
#######################################
function bl64_check_alert_module_setup() {
  local -i last_status=$? # must be first line to catch $?
  bl64_dbg_lib_show_function "$@"
  local module="${1:-}"

  bl64_check_parameter 'module' || return $?

  if [[ "$last_status" != '0' ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_MODULE_SETUP_FAILED} (${_BL64_CHECK_TXT_MODULE}: ${module} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $last_status
  else
    return 0
  fi
}

#######################################
# Check that at least 1 parameter is passed when using dynamic arguments
#
# Arguments:
#   $1: must be $# to capture number of parameters from the calling function
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
function bl64_check_parameters_none() {
  bl64_dbg_lib_show_function "$@"
  local count="$1"

  bl64_check_parameter 'count' || return $?

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
#   $1: module name (eg: BL64_XXXX_MODULE)
# Outputs:
#   STDOUT: none
#   STDERR: message
# Returns:
#   BL64_LIB_ERROR_TASK_UNDEFINED
#######################################
function bl64_check_module() {
  bl64_dbg_lib_show_function "$@"
  local module="${1:-}"
  local setup_status=''

  bl64_check_parameter 'module' || return $?

  if [[ ! -v "$module" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_MODULE_SET} (${_BL64_CHECK_TXT_MODULE}: ${module} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_EXPORT_SET
  fi

  eval setup_status="\$$module"
  if [[ "$setup_status" == "$BL64_VAR_OFF" ]]; then
    bl64_msg_show_error "${_BL64_CHECK_TXT_MODULE_NOT_SETUP} (${_BL64_CHECK_TXT_MODULE}: ${module} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_MODULE_SETUP_MISSING
  fi

  return 0
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
    bl64_msg_show_error "${message} (user: ${user} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
    return $BL64_LIB_ERROR_USER_NOT_FOUND
  else
    return 0
  fi
}

#######################################
# Check exit status
#
# * Helper to check for exit status of the last executed command and show error if failed
# * Return the same status as the latest command. This is to facilitate chaining with && return $? or be the last command of the function
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
    bl64_msg_show_error "${message} (status: ${status} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_CHECK_TXT_FUNCTION}: ${FUNCNAME[1]:-NONE}@${BASH_LINENO[1]:-NONE})"
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
  bl64_dbg_all_disable &&
    BL64_DBG_MODULE="$BL64_VAR_ON"

  # bl64_check_alert_module_setup # Disabled as check is loaded after dbg
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
  "$BL64_DBG_TARGET_APP_CUSTOM_1") bl64_dbg_app_custom_1_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_2") bl64_dbg_app_custom_2_enable ;;
  "$BL64_DBG_TARGET_APP_CUSTOM_3") bl64_dbg_app_custom_3_enable ;;
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
# Stop bashlib64 external command tracing
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
function bl64_dbg_lib_command_trace_stop() {
  local -i state=$?

  bl64_dbg_lib_task_enabled || return $state

  set +x
  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_STOP}"

  return $state
}

#######################################
# Start bashlib64 external command tracing if target is in scope
#
# * Use in functions: bl64_*_run_*
#
# Arguments:
#   None
# Outputs:
#   STDOUT: Tracing
#   STDERR: Debug messages
# Returns:
#   0: always ok
#######################################
function bl64_dbg_lib_command_trace_start() {
  bl64_dbg_lib_task_enabled || return 0

  _bl64_dbg_show "[${FUNCNAME[1]:-NONE}] ${_BL64_DBG_TXT_FUNCTION_START}"
  set -x

  return 0
}

#######################################
# BashLib64 / Module / Setup / Manage local filesystem
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

  _bl64_fs_set_command &&
    _bl64_fs_set_alias &&
    _bl64_fs_set_options &&
    BL64_FS_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'fs'
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
function _bl64_fs_set_command() {
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
  ${BL64_OS_SLES}-*)
    BL64_FS_CMD_CHMOD='/usr/bin/chmod'
    BL64_FS_CMD_CHOWN='/usr/bin/chown'
    BL64_FS_CMD_CP='/usr/bin/cp'
    BL64_FS_CMD_FIND='/usr/bin/find'
    BL64_FS_CMD_LN='/usr/bin/ln'
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
function _bl64_fs_set_options() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
    BL64_FS_SET_CHMOD_VERBOSE='--verbose'
    BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
    BL64_FS_SET_CHOWN_VERBOSE='--verbose'
    BL64_FS_SET_CP_FORCE='--force'
    BL64_FS_SET_CP_RECURSIVE='--recursive'
    BL64_FS_SET_CP_VERBOSE='--verbose'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_SYMBOLIC='--symbolic'
    BL64_FS_SET_LN_VERBOSE='--verbose'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='--parents'
    BL64_FS_SET_MKDIR_VERBOSE='--verbose'
    BL64_FS_SET_MV_FORCE='--force'
    BL64_FS_SET_MV_VERBOSE='--verbose'
    BL64_FS_SET_RM_FORCE='--force'
    BL64_FS_SET_RM_RECURSIVE='--recursive'
    BL64_FS_SET_RM_VERBOSE='--verbose'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
    BL64_FS_SET_CHMOD_VERBOSE='--verbose'
    BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
    BL64_FS_SET_CHOWN_VERBOSE='--verbose'
    BL64_FS_SET_CP_FORCE='--force'
    BL64_FS_SET_CP_RECURSIVE='--recursive'
    BL64_FS_SET_CP_VERBOSE='--verbose'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_SYMBOLIC='--symbolic'
    BL64_FS_SET_LN_VERBOSE='--verbose'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='--parents'
    BL64_FS_SET_MKDIR_VERBOSE='--verbose'
    BL64_FS_SET_MV_FORCE='--force'
    BL64_FS_SET_MV_VERBOSE='--verbose'
    BL64_FS_SET_RM_FORCE='--force'
    BL64_FS_SET_RM_RECURSIVE='--recursive'
    BL64_FS_SET_RM_VERBOSE='--verbose'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='--recursive'
    BL64_FS_SET_CHMOD_VERBOSE='--verbose'
    BL64_FS_SET_CHOWN_RECURSIVE='--recursive'
    BL64_FS_SET_CHOWN_VERBOSE='--verbose'
    BL64_FS_SET_CP_FORCE='--force'
    BL64_FS_SET_CP_RECURSIVE='--recursive'
    BL64_FS_SET_CP_VERBOSE='--verbose'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_SYMBOLIC='--symbolic'
    BL64_FS_SET_LN_VERBOSE='--verbose'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='--parents'
    BL64_FS_SET_MKDIR_VERBOSE='--verbose'
    BL64_FS_SET_MV_FORCE='--force'
    BL64_FS_SET_MV_VERBOSE='--verbose'
    BL64_FS_SET_RM_FORCE='--force'
    BL64_FS_SET_RM_RECURSIVE='--recursive'
    BL64_FS_SET_RM_VERBOSE='--verbose'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='-R'
    BL64_FS_SET_CHMOD_VERBOSE='-v'
    BL64_FS_SET_CHOWN_RECURSIVE='-R'
    BL64_FS_SET_CHOWN_VERBOSE='-v'
    BL64_FS_SET_CP_FORCE='-f'
    BL64_FS_SET_CP_RECURSIVE='-R'
    BL64_FS_SET_CP_VERBOSE='-v'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_SYMBOLIC='-s'
    BL64_FS_SET_LN_VERBOSE='-v'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='-p'
    BL64_FS_SET_MKDIR_VERBOSE=' '
    BL64_FS_SET_MV_FORCE='-f'
    BL64_FS_SET_MV_VERBOSE=' '
    BL64_FS_SET_RM_FORCE='-f'
    BL64_FS_SET_RM_RECURSIVE='-R'
    BL64_FS_SET_RM_VERBOSE=' '
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_FS_SET_CHMOD_RECURSIVE='-R'
    BL64_FS_SET_CHMOD_VERBOSE='-v'
    BL64_FS_SET_CHOWN_RECURSIVE='-R'
    BL64_FS_SET_CHOWN_VERBOSE='-v'
    BL64_FS_SET_CP_FORCE='-f'
    BL64_FS_SET_CP_RECURSIVE='-R'
    BL64_FS_SET_CP_VERBOSE='-v'
    BL64_FS_SET_FIND_PRINT='-print'
    BL64_FS_SET_FIND_RUN='-exec'
    BL64_FS_SET_FIND_STAY='-xdev'
    BL64_FS_SET_FIND_TYPE_DIR='-type d'
    BL64_FS_SET_FIND_TYPE_FILE='-type f'
    BL64_FS_SET_LN_SYMBOLIC='-s'
    BL64_FS_SET_LN_VERBOSE='-v'
    BL64_FS_SET_LS_NOCOLOR='--color=never'
    BL64_FS_SET_MKDIR_PARENTS='-p'
    BL64_FS_SET_MKDIR_VERBOSE='-v'
    BL64_FS_SET_MV_FORCE='-f'
    BL64_FS_SET_MV_VERBOSE='-v'
    BL64_FS_SET_RM_FORCE='-f'
    BL64_FS_SET_RM_RECURSIVE='-R'
    BL64_FS_SET_RM_VERBOSE='-v'
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
function _bl64_fs_set_alias() {
  local cmd_mawk='/usr/bin/mawk'

  BL64_FS_ALIAS_CHOWN_DIR="${BL64_FS_CMD_CHOWN} ${BL64_FS_SET_CHOWN_VERBOSE} ${BL64_FS_SET_CHOWN_RECURSIVE}"
  BL64_FS_ALIAS_CP_DFIND="/usr/bin/find"
  BL64_FS_ALIAS_CP_DIR="${BL64_FS_CMD_CP} ${BL64_FS_SET_CP_VERBOSE} ${BL64_FS_SET_CP_FORCE} ${BL64_FS_SET_CP_RECURSIVE}"
  BL64_FS_ALIAS_CP_FIFIND="/usr/bin/find"
  BL64_FS_ALIAS_CP_FILE="${BL64_FS_CMD_CP} ${BL64_FS_SET_CP_VERBOSE} ${BL64_FS_SET_CP_FORCE}"
  BL64_FS_ALIAS_LN_SYMBOLIC="${BL64_FS_CMD_LN} ${BL64_FS_SET_LN_SYMBOLIC} ${BL64_FS_SET_LN_VERBOSE}"
  BL64_FS_ALIAS_LS_FILES="${BL64_FS_CMD_LS} ${BL64_FS_SET_LS_NOCOLOR}"
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
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
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

    bl64_msg_show_lib_subtask "${_BL64_FS_TXT_CREATE_DIR_PATH} (${path})"
    bl64_fs_run_mkdir "$path" &&
      bl64_fs_set_permissions "$mode" "$user" "$group" "$path" ||
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
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local destination="${4:-${BL64_VAR_DEFAULT}}"
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
      target="${destination}/$(bl64_fmt_basename "$path")" || return $?

    bl64_msg_show_lib_subtask "${_BL64_FS_TXT_COPY_FILE_PATH} (${path} ${BL64_MSG_COSMETIC_ARROW2} ${target})"
    bl64_fs_cp_file "$path" "$target" &&
      bl64_fs_set_permissions "$mode" "$user" "$group" "$target" ||
      return $?
  done

  return 0
}

#######################################
# Merge 2 or more files into a new one, then set owner and permissions
#
# * If the destination is already present no update is done unless requested
# * If asked to replace destination, no backup is done. User must take one if needed
# * If merge fails the incomplete file will be removed
#
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: current
#   $3: group name. Default: current
#   $4: replace existing content. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
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
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local replace="${4:-${BL64_VAR_DEFAULT}}"
  local destination="${5:-${BL64_VAR_DEFAULT}}"
  local path=''
  local -i status=0
  local -i first=1

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

  for path in "$@"; do
    bl64_msg_show_lib_subtask "${_BL64_FS_TXT_MERGE_ADD_SOURCE} (${path})"
    if ((first == 1)); then
      first=0
      bl64_check_path_absolute "$path" &&
        "$BL64_OS_CMD_CAT" "$path" >"$destination"
    else
      bl64_check_path_absolute "$path" &&
        "$BL64_OS_CMD_CAT" "$path" >>"$destination"
    fi
    status=$?
    ((status != 0)) && break
    :
  done

  if ((status == 0)); then
    bl64_dbg_lib_show_info "merge commplete, update permissions if needed (${destination})"
    bl64_fs_set_permissions "$mode" "$user" "$group" "$destination"
    status=$?
  else
    bl64_dbg_lib_show_info "merge failed, removing incomplete file (${destination})"
    [[ -f "$destination" ]] && bl64_fs_rm_file "$destination"
  fi

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
  local source="${1:-${BL64_VAR_DEFAULT}}"
  local target="${2:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'source' &&
    bl64_check_parameter 'target' &&
    bl64_check_directory "$source" &&
    bl64_check_directory "$target" ||
    return $?

  bl64_msg_show_lib_subtask "${_BL64_FS_TXT_MERGE_DIRS} (${source} ${BL64_MSG_COSMETIC_ARROW2} ${target})"
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    bl64_fs_cp_dir --no-target-directory "$source" "$target"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    bl64_fs_cp_dir --no-target-directory "$source" "$target"
    ;;
  ${BL64_OS_SLES}-*)
    bl64_fs_cp_dir --no-target-directory "$source" "$target"
    ;;
  ${BL64_OS_ALP}-*)
    # shellcheck disable=SC2086
    shopt -sq dotglob &&
      bl64_fs_cp_dir ${source}/* -t "$target" &&
      shopt -uq dotglob
    ;;
  ${BL64_OS_MCOS}-*)
    # shellcheck disable=SC2086
    bl64_fs_cp_dir ${source}/ "$target"
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
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
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
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
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
# Change directory permissions recursively
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_chmod_dir() {
  bl64_dbg_lib_show_function "$@"

  # shellcheck disable=SC2086
  bl64_fs_run_chmod "$BL64_FS_SET_CHMOD_RECURSIVE" "$@"
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
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
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
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
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

  bl64_check_parameters_none "$#" || return $?

  bl64_fs_run_rm "$BL64_FS_SET_RM_FORCE" "$@"
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

  bl64_check_parameters_none "$#" || return $?

  bl64_fs_run_rm "$BL64_FS_SET_RM_FORCE" "$BL64_FS_SET_RM_RECURSIVE" "$@"
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
  local target=''

  target='/tmp'
  bl64_msg_show_lib_subtask "${_BL64_FS_TXT_CLEANUP_TEMP} (${target})"
  bl64_fs_rm_full -- ${target}/[[:alnum:]]*

  target='/var/tmp'
  bl64_msg_show_lib_subtask "${_BL64_FS_TXT_CLEANUP_TEMP} (${target})"
  bl64_fs_rm_full -- ${target}/[[:alnum:]]*
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
    bl64_msg_show_lib_subtask "${_BL64_FS_TXT_CLEANUP_LOGS} (${target})"
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
    bl64_msg_show_lib_subtask "${_BL64_FS_TXT_CLEANUP_CACHES} (${target})"
    bl64_fs_rm_full ${target}/[[:alnum:]]*
  fi
  return 0
}

#######################################
# Performs a complete cleanup of OS ephemeral content
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
  local pattern="${2:-${BL64_VAR_DEFAULT}}"
  local content="${3:-${BL64_VAR_DEFAULT}}"

  bl64_check_command "$BL64_FS_CMD_FIND" &&
    bl64_check_directory "$path" || return $?

  [[ "$pattern" == "$BL64_VAR_DEFAULT" ]] && pattern=''

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  if [[ "$content" == "$BL64_VAR_DEFAULT" ]]; then
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

  bl64_msg_show_lib_subtask "${_BL64_FS_TXT_SAFEGUARD_OBJECT} ([${destination}]->[${backup}])"
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
  if [[ "$result" == "$BL64_VAR_OK" ]]; then
    bl64_dbg_lib_show_info 'operation was ok, backup no longer needed, remove it'
    [[ -e "$backup" ]] && bl64_fs_rm_full "$backup"

    # shellcheck disable=SC2086
    return $BL64_VAR_OK
  else
    bl64_dbg_lib_show_info 'operation was NOT ok, remove invalid content'
    [[ -e "$destination" ]] && bl64_fs_rm_full "$destination"

    bl64_msg_show_lib_subtask "${_BL64_FS_TXT_RESTORE_OBJECT} ([${backup}]->[${destination}])"
    # shellcheck disable=SC2086
    bl64_fs_run_mv "$backup" "$destination" ||
      return $BL64_LIB_ERROR_TASK_RESTORE
  fi
}

#######################################
# Set object permissions and ownership
#
# * work on individual files
# * no recurse option
# * all files get the same permissions, user, group
#
# Arguments:
#   $1: permissions. Format: chown format. Default: use current umask
#   $2: user name. Default: nonde
#   $3: group name. Default: current
#   $@: list of objects. Must use full path for each
# Outputs:
#   STDOUT: command stdin
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_set_permissions() {
  bl64_dbg_lib_show_function "$@"
  local mode="${1:-${BL64_VAR_DEFAULT}}"
  local user="${2:-${BL64_VAR_DEFAULT}}"
  local group="${3:-${BL64_VAR_DEFAULT}}"
  local path=''

  # Remove consumed parameters
  shift
  shift
  shift

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "path list:[${*}]"

  # Determine if mode needs to be set
  if [[ "$mode" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_run_chmod "$mode" "$@" || return $?
  fi

  # Determine if owner needs to be set
  if [[ "$user" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_run_chown "${user}" "$@" || return $?
  fi

  # Determine if group needs to be set
  if [[ "$group" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_run_chown ":${group}" "$@" || return $?
  fi

  return 0
}

#######################################
# Fix path permissions
#
# * allow different permissions for files and directories
# * recursive
#
# Arguments:
#   $1: file permissions. Format: chown format. Default: no action
#   $2: directory permissions. Format: chown format. Default: no action
#   $@: list of paths. Must use full path for each
# Outputs:
#   STDOUT: command stdin
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_fs_fix_permissions() {
  bl64_dbg_lib_show_function "$@"
  local file_mode="${1:-${BL64_VAR_DEFAULT}}"
  local dir_mode="${2:-${BL64_VAR_DEFAULT}}"
  local path=''

  # Remove consumed parameters
  shift
  shift

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_show_info "path list:[${*}]"

  if [[ "$file_mode" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_dbg_lib_show_info "fix file permissions (${file_mode})"
    # shellcheck disable=SC2086
    bl64_fs_run_find \
      "$@" \
      ${BL64_FS_SET_FIND_STAY} \
      ${BL64_FS_SET_FIND_TYPE_FILE} \
      ${BL64_FS_SET_FIND_RUN} "$BL64_FS_CMD_CHMOD" "$file_mode" "{}" \; ||
      return $?
  fi

  if [[ "$dir_mode" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_dbg_lib_show_info "fix directory permissions (${dir_mode})"
    # shellcheck disable=SC2086
    bl64_fs_run_find \
      "$@" \
      ${BL64_FS_SET_FIND_STAY} \
      ${BL64_FS_SET_FIND_TYPE_DIR} \
      ${BL64_FS_SET_FIND_RUN} "$BL64_FS_CMD_CHMOD" "$dir_mode" "{}" \; ||
      return $?
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
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
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
function bl64_fs_run_rm() {
  bl64_dbg_lib_show_function "$@"
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
  bl64_dbg_lib_command_enabled && verbose="$BL64_FS_SET_CP_VERBOSE"

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_FS_CMD_RM" $verbose "$@"
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
  local verbose=''

  bl64_check_parameters_none "$#" || return $?
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
  local temporal="${1:-${BL64_VAR_DEFAULT}}"
  local cache="${2:-${BL64_VAR_DEFAULT}}"
  local mode="${3:-${BL64_VAR_DEFAULT}}"
  local user="${4:-${BL64_VAR_DEFAULT}}"
  local group="${5:-${BL64_VAR_DEFAULT}}"

  if [[ "$temporal" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_create_dir "$mode" "$user" "$group" "$temporal" &&
      BL64_FS_PATH_TEMPORAL="$temporal" ||
      return $?
  fi

  if [[ "$cache" != "$BL64_VAR_DEFAULT" ]]; then
    bl64_fs_create_dir "$mode" "$user" "$group" "$cache" &&
      BL64_FS_PATH_CACHE="$cache" ||
      return $?
  fi

  return 0
}

#######################################
# BashLib64 / Module / Setup / Format text data
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
function bl64_fmt_setup() {
  bl64_dbg_lib_show_function

  BL64_FMT_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'fmt'
}

#######################################
# BashLib64 / Module / Functions / Format text data
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

  bl64_txt_run_egrep "$BL64_TXT_SET_GREP_INVERT" '^#.*$|^ *#.*$' "$source"
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
    return $BL64_VAR_OK
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
    return $BL64_VAR_OK
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
    return $BL64_VAR_OK
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
  local field_separator="${1:-${BL64_VAR_DEFAULT}}"
  local prefix="${2:-${BL64_VAR_DEFAULT}}"
  local postfix="${3:-${BL64_VAR_DEFAULT}}"

  [[ "$field_separator" == "$BL64_VAR_DEFAULT" ]] && field_separator=' '
  [[ "$prefix" == "$BL64_VAR_DEFAULT" ]] && prefix=''
  [[ "$postfix" == "$BL64_VAR_DEFAULT" ]] && postfix=''

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
# BashLib64 / Module / Setup / Display messages
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
function bl64_msg_setup() {
  bl64_dbg_lib_show_function

  bl64_msg_set_output "$BL64_MSG_OUTPUT_ANSI" &&
    bl64_msg_app_enable_verbose &&
    BL64_MSG_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'msg'
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
  bl64_dbg_lib_show_function "$@"
  local level="$1"

  bl64_check_parameter 'level' || return $?

  case "$level" in
  "$BL64_MSG_VERBOSE_NONE")
    bl64_msg_all_disable_verbose
    ;;
  "$BL64_MSG_VERBOSE_APP")
    bl64_msg_app_enable_verbose
    ;;
  "$BL64_MSG_VERBOSE_LIB")
    bl64_msg_lib_enable_verbose
    ;;
  "$BL64_MSG_VERBOSE_ALL")
    bl64_msg_all_enable_verbose
    ;;
  *)
    bl64_check_alert_parameter_invalid 'BL64_MSG_VERBOSE' \
      "${_BL64_MSG_TXT_INVALID_VALUE}: ${BL64_MSG_VERBOSE_NONE}|${BL64_MSG_VERBOSE_ALL}|${BL64_MSG_VERBOSE_APP}|${BL64_MSG_VERBOSE_LIB}"
    return $?
    ;;
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
  bl64_dbg_lib_show_function "$@"
  local format="$1"

  bl64_check_parameter 'format' || return $?

  case "$format" in
  "$BL64_MSG_FORMAT_PLAIN")
    BL64_MSG_FORMAT="$BL64_MSG_FORMAT_PLAIN"
    ;;
  "$BL64_MSG_FORMAT_HOST")
    BL64_MSG_FORMAT="$BL64_MSG_FORMAT_HOST"
    ;;
  "$BL64_MSG_FORMAT_TIME")
    BL64_MSG_FORMAT="$BL64_MSG_FORMAT_TIME"
    ;;
  "$BL64_MSG_FORMAT_CALLER")
    BL64_MSG_FORMAT="$BL64_MSG_FORMAT_CALLER"
    ;;
  "$BL64_MSG_FORMAT_FULL")
    BL64_MSG_FORMAT="$BL64_MSG_FORMAT_FULL"
    ;;
  *)
    bl64_check_alert_parameter_invalid 'BL64_MSG_FORMAT' \
      "${_BL64_MSG_TXT_INVALID_VALUE}: ${BL64_MSG_FORMAT_PLAIN}|${BL64_MSG_FORMAT_HOST}|${BL64_MSG_FORMAT_TIME}|${BL64_MSG_FORMAT_CALLER}|${BL64_MSG_FORMAT_FULL}"
    return $?
    ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_MSG_FORMAT'
}

#######################################
# Set message display theme
#
# Arguments:
#   $1: theme name. One of BL64_MSG_THEME_ID_*
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_theme() {
  bl64_dbg_lib_show_function "$@"
  local theme="$1"

  bl64_check_parameter 'theme' || return $?

  case "$theme" in
  "$BL64_MSG_THEME_ID_ASCII_STD")
    BL64_MSG_THEME='BL64_MSG_THEME_ASCII_STD'
    ;;
  "$BL64_MSG_THEME_ID_ANSI_STD")
    BL64_MSG_THEME='BL64_MSG_THEME_ANSI_STD'
    ;;
  *)
    bl64_check_alert_parameter_invalid 'BL64_MSG_THEME' \
      "${_BL64_MSG_TXT_INVALID_VALUE}: ${BL64_MSG_THEME_ID_ASCII_STD}|${BL64_MSG_THEME_ID_ANSI_STD}"
    return $?
    ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_MSG_THEME'
}

#######################################
# Set message output type
#
# * Will also setup the theme
# * If no theme is provided then the STD is used (ansi or ascii)
#
# Arguments:
#   $1: output type. One of BL64_MSG_OUTPUT_*
#   $2: (optional) theme. Default: STD
# Outputs:
#   STDOUT: None
#   STDERR: parameter error
# Returns:
#   0: successfull execution
#   BL64_LIB_ERROR_PARAMETER_INVALID
#######################################
function bl64_msg_set_output() {
  bl64_dbg_lib_show_function "$@"
  local output="${1:-}"
  local theme="${2:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'output' || return $?

  case "$output" in
  "$BL64_MSG_OUTPUT_ASCII")
    [[ "$theme" == "$BL64_VAR_DEFAULT" ]] && theme="$BL64_MSG_THEME_ID_ASCII_STD"
    BL64_MSG_OUTPUT="$output"
    ;;
  "$BL64_MSG_OUTPUT_ANSI")
    [[ "$theme" == "$BL64_VAR_DEFAULT" ]] && theme="$BL64_MSG_THEME_ID_ANSI_STD"
    BL64_MSG_OUTPUT="$output"
    ;;
  *)
    bl64_check_alert_parameter_invalid 'BL64_MSG_OUTPUT' \
      "${_BL64_MSG_TXT_INVALID_VALUE}: ${BL64_MSG_OUTPUT_ASCII}|${BL64_MSG_OUTPUT_ANSI}"
    return $?
    ;;
  esac
  bl64_dbg_lib_show_vars 'BL64_MSG_OUTPUT'
  bl64_msg_set_theme "$theme"
}

#
# Verbosity control
#

function bl64_msg_app_verbose_enabled {
  bl64_dbg_lib_show_function
  local -i enabled=0
  [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_APP" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]
  enabled=$?
  bl64_dbg_lib_show_info "app verbose enabled: ${enabled}"
  return $enabled
}
function bl64_msg_lib_verbose_enabled {
  bl64_dbg_lib_show_function
  [[ "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_LIB" || "$BL64_MSG_VERBOSE" == "$BL64_MSG_VERBOSE_ALL" ]]
  enabled=$?
  bl64_dbg_lib_show_info "lib verbose enabled: ${enabled}"
  return $enabled
}

function bl64_msg_all_disable_verbose {
  bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_NONE"
  bl64_dbg_lib_show_vars 'BL64_MSG_VERBOSE'
}
function bl64_msg_all_enable_verbose {
  bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_ALL"
  bl64_dbg_lib_show_vars 'BL64_MSG_VERBOSE'
}
function bl64_msg_lib_enable_verbose {
  bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_LIB"
  bl64_dbg_lib_show_vars 'BL64_MSG_VERBOSE'
}
function bl64_msg_app_enable_verbose {
  bl64_dbg_lib_show_function
  BL64_MSG_VERBOSE="$BL64_MSG_VERBOSE_APP"
  bl64_dbg_lib_show_vars 'BL64_MSG_VERBOSE'
}

#######################################
# BashLib64 / Module / Functions / Display messages
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
  bl64_dbg_lib_show_function "$@"
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
  bl64_dbg_lib_show_function "$@"
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
  bl64_dbg_lib_show_function "$@"
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
  bl64_dbg_lib_show_function "$@"
  local usage="${1:-${BL64_VAR_NULL}}"
  local description="${2:-${BL64_VAR_DEFAULT}}"
  local commands="${3:-${BL64_VAR_DEFAULT}}"
  local flags="${4:-${BL64_VAR_DEFAULT}}"
  local parameters="${5:-${BL64_VAR_DEFAULT}}"

  bl64_check_parameter 'usage' || return $?

  printf '\n%s: %s %s\n\n' "$_BL64_MSG_TXT_USAGE" "$BL64_SCRIPT_ID" "$usage"

  if [[ "$description" != "$BL64_VAR_DEFAULT" ]]; then
    printf '%s\n\n' "$description"
  fi

  if [[ "$commands" != "$BL64_VAR_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_COMMANDS" "$commands"
  fi

  if [[ "$flags" != "$BL64_VAR_DEFAULT" ]]; then
    printf '%s\n%s\n' "$_BL64_MSG_TXT_FLAGS" "$flags"
  fi

  if [[ "$parameters" != "$BL64_VAR_DEFAULT" ]]; then
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
  bl64_dbg_lib_show_function "$@"
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
  bl64_dbg_lib_show_function "$@"
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
  bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "$message" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_INFO" "$_BL64_MSG_TXT_INFO" "$message"
}

#######################################
# Display phase message
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
function bl64_msg_show_phase() {
  bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_PHASE}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_PHASE" "$_BL64_MSG_TXT_PHASE" "${BL64_MSG_COSMETIC_PHASE_PREFIX} ${message} ${BL64_MSG_COSMETIC_PHASE_SUFIX}"
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
  bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_TASK}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_TASK" "$_BL64_MSG_TXT_TASK" "$message"
}

#######################################
# Display subtask message
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
function bl64_msg_show_subtask() {
  bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_SUBTASK}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_SUBTASK" "$_BL64_MSG_TXT_SUBTASK" "${BL64_MSG_COSMETIC_ARROW2} ${message}"
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
  bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBTASK}:${message}" &&
    bl64_msg_lib_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_LIBTASK" "$_BL64_MSG_TXT_TASK" "$message"
}

#######################################
# Display subtask message for bash64lib functions
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
function bl64_msg_show_lib_subtask() {
  bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBSUBTASK}:${message}" &&
    bl64_msg_app_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_LIBSUBTASK" "$_BL64_MSG_TXT_SUBTASK" "${BL64_MSG_COSMETIC_ARROW2} ${message}"
}

#######################################
# Display info message for bash64lib functions
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
function bl64_msg_show_lib_info() {
  bl64_dbg_lib_show_function "$@"
  local message="$1"

  bl64_log_info "${FUNCNAME[1]:-MAIN}" "${BL64_MSG_TYPE_LIBINFO}:${message}" &&
    bl64_msg_lib_verbose_enabled || return 0

  _bl64_msg_show "$BL64_MSG_TYPE_LIBINFO" "$_BL64_MSG_TXT_INFO" "$message"
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
  bl64_dbg_lib_show_function "$@"
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
  bl64_dbg_lib_show_function "$@"
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
  bl64_dbg_lib_show_function "$@"
  local status="$1"
  local message="${2-${BL64_VAR_DEFAULT}}"

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
  bl64_dbg_lib_show_function "$@"
  local message="$1"

  _bl64_msg_show "$BL64_MSG_TYPE_INPUT" "$_BL64_MSG_TXT_INPUT" "$message"
}

#######################################
# BashLib64 / Module / Setup / OS / Identify OS attributes and provide command aliases
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

  _bl64_os_set_distro &&
    _bl64_os_set_runtime &&
    _bl64_os_set_command &&
    _bl64_os_set_options &&
    BL64_OS_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'os'
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
function _bl64_os_set_command() {
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_OS_CMD_BASH='/bin/bash'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/bin/false'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TRUE='/bin/true'
    BL64_OS_CMD_UNAME='/bin/uname'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_OS_CMD_BASH='/bin/bash'
    BL64_OS_CMD_CAT='/usr/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/usr/bin/false'
    BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TRUE='/usr/bin/true'
    BL64_OS_CMD_UNAME='/bin/uname'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_OS_CMD_BASH='/usr/bin/bash'
    BL64_OS_CMD_CAT='/usr/bin/cat'
    BL64_OS_CMD_DATE='/usr/bin/date'
    BL64_OS_CMD_FALSE='/usr/bin/false'
    BL64_OS_CMD_HOSTNAME='/usr/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TRUE='/usr/bin/true'
    BL64_OS_CMD_UNAME='/usr/bin/uname'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_OS_CMD_BASH='/bin/bash'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/bin/false'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TRUE='/bin/true'
    BL64_OS_CMD_UNAME='/bin/uname'
    ;;
  ${BL64_OS_MCOS}-*)
    # Homebrew used when no native option available
    BL64_OS_CMD_BASH='/opt/homebre/bin/bash'
    BL64_OS_CMD_CAT='/bin/cat'
    BL64_OS_CMD_DATE='/bin/date'
    BL64_OS_CMD_FALSE='/usr/bin/false'
    BL64_OS_CMD_HOSTNAME='/bin/hostname'
    BL64_OS_CMD_LOCALE='/usr/bin/locale'
    BL64_OS_CMD_TRUE='/usr/bin/true'
    BL64_OS_CMD_UNAME='/usr/bin/uname'
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
function _bl64_os_set_options() {
  bl64_dbg_lib_show_function

  BL64_OS_SET_LOCALE_ALL='--all-locales'
}

#######################################
# Set runtime defaults
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: always ok
#######################################
function _bl64_os_set_runtime() {
  bl64_dbg_lib_show_function

  # Reset language to modern specification of C locale
  if [[ "$BL64_LIB_LANG" == '1' ]]; then
    # shellcheck disable=SC2034
    case "$BL64_OS_DISTRO" in
    ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
      bl64_os_set_lang 'C.UTF-8'
      ;;
    ${BL64_OS_FD}-*)
      bl64_os_set_lang 'C.UTF-8'
      ;;
    ${BL64_OS_CNT}-8.* | ${BL64_OS_CNT}-9.* | ${BL64_OS_RHEL}-8.* | ${BL64_OS_RHEL}-9.* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-8.* | ${BL64_OS_OL}-9.* | ${BL64_OS_RCK}-*)
      bl64_os_set_lang 'C.UTF-8'
      ;;
    ${BL64_OS_CNT}-7.* | ${BL64_OS_OL}-7.*)
      # Not installed by default, skipping
      ;;
    ${BL64_OS_SLES}-*)
      bl64_os_set_lang 'C.UTF-8'
      ;;
    ${BL64_OS_ALP}-*)
      # Not installed by default, skipping
      ;;
    ${BL64_OS_MCOS}-*)
      # Not installed by default, skipping
      ;;
    *)
      bl64_check_alert_unsupported
      return $?
      ;;
    esac
  fi

  return 0
}

#######################################
# Set locale related shell variables
#
# * Locale variables are set as is, no extra validation on the locale availability
#
# Arguments:
#   $1: locale name
# Outputs:
#   STDOUT: None
#   STDERR: Validation errors
# Returns:
#   0: set ok
#   >0: set error
#######################################
function bl64_os_set_lang() {
  bl64_dbg_lib_show_function "$@"
  local locale="$1"

  bl64_check_parameter 'locale' || return $?

  LANG="$locale"
  LC_ALL="$locale"
  LANGUAGE="$locale"
  bl64_dbg_lib_show_vars 'LANG' 'LC_ALL' 'LANGUAGE'

  return 0
}

#######################################
# BashLib64 / Module / Functions / OS / Identify OS attributes and provide command aliases
#######################################

function _bl64_os_match() {
  bl64_dbg_lib_show_function "$@"
  local target="$1"
  local os=''
  local os_version=''

  if [[ "$target" == +([[:alpha:]])-+([[:digit:]]).+([[:digit:]]) ]]; then
    os="${target%%-*}"
    os_version="${target##*-}"
    bl64_dbg_lib_show_info "Pattern: OOO-V.V [${BL64_OS_DISTRO}] == [${os}-${os_version}]"
    [[ "$BL64_OS_DISTRO" == "${os}-${os_version}" ]] || return $BL64_LIB_ERROR_OS_NOT_MATCH
  elif [[ "$target" == +([[:alpha:]])-+([[:digit:]]) ]]; then
    os="${target%%-*}"
    os_version="${target##*-}"
    bl64_dbg_lib_show_info "Pattern: OOO-V [${BL64_OS_DISTRO}] == [${os}-${os_version}.+([[:digit:]])]"
    [[ "$BL64_OS_DISTRO" == ${os}-${os_version}.+([[:digit:]]) ]] || return $BL64_LIB_ERROR_OS_NOT_MATCH
  elif [[ "$target" == +([[:alpha:]]) ]]; then
    os="$target"
    bl64_dbg_lib_show_info "Pattern: OOO [${BL64_OS_DISTRO}] == [${os}]"
    [[ "$BL64_OS_DISTRO" == ${os}-+([[:digit:]]).+([[:digit:]]) ]] || return $BL64_LIB_ERROR_OS_NOT_MATCH
  else
    bl64_msg_show_error "${_BL64_OS_TXT_INVALID_OS_PATTERN} (${target})"
    return $BL64_LIB_ERROR_OS_TAG_INVALID
  fi

  return 0
}

#######################################
# Get normalized OS distro and version from uname
#
# * Warning: bootstrap function
# * Use only for OS that do not have /etc/os-release
# * Normalized data is stored in the global variable BL64_OS_DISTRO
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   >0: error or os not recognized
#######################################
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
    bl64_msg_show_error "${_BL64_OS_TXT_OS_NOT_SUPPORTED} ($(uname -a))"
    return $BL64_LIB_ERROR_OS_INCOMPATIBLE
  fi
  bl64_dbg_lib_show_vars 'BL64_OS_DISTRO'

  return 0
}

#######################################
# Get normalized OS distro and version from os-release
#
# * Warning: bootstrap function
# * Normalized data is stored in the global variable BL64_OS_DISTRO
#
# Arguments:
#   None
# Outputs:
#   STDOUT: None
#   STDERR: None
# Returns:
#   0: os match
#   >0: error or os not recognized
#######################################
function _bl64_os_get_distro_from_os_release() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC1091
  source '/etc/os-release'
  if [[ -n "${ID:-}" && -n "${VERSION_ID:-}" ]]; then
    BL64_OS_DISTRO="${ID^^}-${VERSION_ID}"
  fi

  case "$BL64_OS_DISTRO" in
  ${BL64_OS_ALM}-8* | ${BL64_OS_ALM}-9*) : ;;
  ${BL64_OS_ALP}-3*) BL64_OS_DISTRO="${BL64_OS_ALP}-${VERSION_ID%.*}" ;;
  ${BL64_OS_CNT}-7*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_CNT}-7" ]] && BL64_OS_DISTRO="${BL64_OS_CNT}-7.0" ;;
  ${BL64_OS_CNT}-8*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_CNT}-8" ]] && BL64_OS_DISTRO="${BL64_OS_CNT}-8.0" ;;
  ${BL64_OS_CNT}-9*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_CNT}-9" ]] && BL64_OS_DISTRO="${BL64_OS_CNT}-9.0" ;;
  ${BL64_OS_DEB}-9*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-9" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-9.0" ;;
  ${BL64_OS_DEB}-10*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-10" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-10.0" ;;
  ${BL64_OS_DEB}-11*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_DEB}-11" ]] && BL64_OS_DISTRO="${BL64_OS_DEB}-11.0" ;;
  ${BL64_OS_FD}-33*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-33" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-33.0" ;;
  ${BL64_OS_FD}-34*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-34" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-34.0" ;;
  ${BL64_OS_FD}-35*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-35" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-35.0" ;;
  ${BL64_OS_FD}-36*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-36" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-36.0" ;;
  ${BL64_OS_FD}-37*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-37" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-37.0" ;;
  ${BL64_OS_FD}-38*) [[ "$BL64_OS_DISTRO" == "${BL64_OS_FD}-38" ]] && BL64_OS_DISTRO="${BL64_OS_FD}-38.0" ;;
  ${BL64_OS_OL}-7* | ${BL64_OS_OL}-8* | ${BL64_OS_OL}-9*) : ;;
  ${BL64_OS_RCK}-8* | ${BL64_OS_RCK}-9*) : ;;
  ${BL64_OS_RHEL}-8* | ${BL64_OS_RHEL}-9*) : ;;
  ${BL64_OS_SLES}-15*) : ;;
  ${BL64_OS_UB}-18.* | ${BL64_OS_UB}-20.* | ${BL64_OS_UB}-21.* | ${BL64_OS_UB}-22.* | ${BL64_OS_UB}-23.*) : ;;
  *) BL64_OS_DISTRO="$BL64_OS_UNK" ;;
  esac

  if [[ "$BL64_OS_DISTRO" == "$BL64_OS_UNK" ]]; then
    bl64_msg_show_error "${_BL64_OS_TXT_FAILED_TO_NORMALIZE_OS} (ID=${ID:-NONE} | VERSION_ID=${VERSION_ID:-NONE}). ${_BL64_OS_TXT_CHECK_OS_MATRIX}"
    return $BL64_LIB_ERROR_OS_INCOMPATIBLE
  fi
  bl64_dbg_lib_show_vars 'BL64_OS_DISTRO'

  return 0
}

#######################################
# Compare the current OS version against a list of OS versions
#
# Arguments:
#   $@: each argument is an OS target. The list is any combintation of the formats: "$BL64_OS_<ALIAS>" "${BL64_OS_<ALIAS>}-V" "${BL64_OS_<ALIAS>}-V.S"
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
  local -i status=$BL64_LIB_ERROR_OS_NOT_MATCH

  bl64_check_module 'BL64_OS_MODULE' || return $?

  bl64_dbg_lib_show_info "Look for [BL64_OS_DISTRO=${BL64_OS_DISTRO}] in [OSList=${*}}]"
  # shellcheck disable=SC2086
  for item in "$@"; do
    _bl64_os_match "$item"
    status=$?
    ((status == 0)) && break
  done

  # shellcheck disable=SC2086
  return $status
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
function _bl64_os_set_distro() {
  bl64_dbg_lib_show_function
  if [[ -r '/etc/os-release' ]]; then
    _bl64_os_get_distro_from_os_release
  else
    _bl64_os_get_distro_from_uname
  fi
}

#######################################
# Determine if locale resources for language are installed in the OS
#
# Arguments:
#   $1: locale name
# Outputs:
#   STDOUT: None
#   STDERR: Validation errors
# Returns:
#   0: resources are installed
#   >0: no resources
#######################################
function bl64_os_lang_is_available() {
  bl64_dbg_lib_show_function "$@"
  local locale="$1"
  local line=''

  bl64_check_module 'BL64_OS_MODULE' &&
    bl64_check_parameter 'locale' &&
    bl64_check_command "$BL64_OS_CMD_LOCALE" ||
    return $?

  bl64_dbg_lib_show_info 'look for the requested locale using the locale command'
  IFS=$'\n'
  for line in $("$BL64_OS_CMD_LOCALE" "$BL64_OS_SET_LOCALE_ALL"); do
    unset IFS
    bl64_dbg_lib_show_info "checking [${line}] == [${locale}]"
    [[ "$line" == "$locale" ]] && return 0
  done

  return 1
}

#######################################
# Check the current OS version is in the supported list
#
# * Target use case is script compatibility. Use in the init part to halt execution if OS is not supported
# * Not recommended for checking individual functions. Instead, use if or case structures to support multiple values based on the OS version
# * The check is done against the provided list
# * This is a wrapper to the bl64_os_match so it can be used as a check function
#
# Arguments:
#   $@: list of OS versions to check against. Format: same as bl64_os_match
# Outputs:
#   STDOUT: None
#   STDERR: Error message
# Returns:
#   0: check ok
#   $BL64_LIB_ERROR_APP_INCOMPATIBLE
#######################################
function bl64_os_check_version() {
  bl64_dbg_lib_show_function "$@"

  bl64_os_match "$@" && return 0

  bl64_msg_show_error "${_BL64_OS_TXT_OS_VERSION_NOT_SUPPORTED} (OS: ${BL64_OS_DISTRO} ${BL64_MSG_COSMETIC_PIPE} ${_BL64_OS_TXT_OS_MATRIX}: ${*})"
  return $BL64_LIB_ERROR_APP_INCOMPATIBLE
}

#######################################
# BashLib64 / Module / Setup / Manage role based access service
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

  _bl64_rbac_set_command &&
    _bl64_rbac_set_options &&
    _bl64_rbac_set_alias &&
    BL64_RBAC_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'rbac'
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
function _bl64_rbac_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
    BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
    BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
    BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
    BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
    BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
    BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RBAC_CMD_SUDO='/usr/bin/sudo'
    BL64_RBAC_CMD_VISUDO='/usr/sbin/visudo'
    BL64_RBAC_FILE_SUDOERS='/etc/sudoers'
    ;;
  ${BL64_OS_MCOS}-*)
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
function _bl64_rbac_set_alias() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_RBAC_ALIAS_SUDO_ENV="$BL64_RBAC_CMD_SUDO --preserve-env --set-home"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RBAC_ALIAS_SUDO_ENV="$BL64_RBAC_CMD_SUDO --preserve-env --set-home"
    ;;
   ${BL64_OS_SLES}-*)
    BL64_RBAC_ALIAS_SUDO_ENV="$BL64_RBAC_CMD_SUDO --preserve-env --set-home"
    ;;
   ${BL64_OS_ALP}-*)
    BL64_RBAC_ALIAS_SUDO_ENV="$BL64_RBAC_CMD_SUDO --preserve-env --set-home"
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RBAC_ALIAS_SUDO_ENV="$BL64_RBAC_CMD_SUDO --preserve-env --set-home"
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
function _bl64_rbac_set_options() {
  bl64_dbg_lib_show_function

  BL64_RBAC_SET_SUDO_CHECK='--check'
  BL64_RBAC_SET_SUDO_FILE='--file'
  BL64_RBAC_SET_SUDO_QUIET='--quiet'
}

#######################################
# BashLib64 / Module / Functions / Manage role based access service
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

  bl64_msg_show_lib_subtask "$_BL64_RBAC_TXT_ADD_ROOT ($user)"
  umask 0266

  if [[ -s "$BL64_RBAC_FILE_SUDOERS" ]]; then
    bl64_dbg_lib_show_info "backup original sudoers (${BL64_RBAC_FILE_SUDOERS} -> ${old_sudoers})"
    bl64_fs_cp_file "${BL64_RBAC_FILE_SUDOERS}" "$old_sudoers"
    status=$?
    ((status != 0)) && bl64_msg_show_error "unable to backup sudoers file (${BL64_RBAC_FILE_SUDOERS})" && return $status

    bl64_dbg_lib_show_info "create new sudoers (${new_sudoers})"
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
    status=$?
    ((status != 0)) && bl64_msg_show_error "unable to create new sudoers file (${new_sudoers})" && return $status

    bl64_dbg_lib_show_info "replace original sudoers with new version (${new_sudoers} ->${BL64_RBAC_FILE_SUDOERS})"
    "$BL64_OS_CMD_CAT" "$new_sudoers" >"${BL64_RBAC_FILE_SUDOERS}"
    status=$?
    ((status != 0)) && bl64_msg_show_error "unable to promote new sudoers file (${new_sudoers}->${BL64_RBAC_FILE_SUDOERS})" && return $status
  else
    printf '%s ALL=(ALL) NOPASSWD: ALL\n' "$user" > "$BL64_RBAC_FILE_SUDOERS"
    status=$?
    ((status != 0)) && bl64_msg_show_error "unable to create new sudoers file (${BL64_RBAC_FILE_SUDOERS})" && return $status
  fi

  bl64_rbac_check_sudoers "$BL64_RBAC_FILE_SUDOERS"
  status=$?

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
  local debug="$BL64_RBAC_SET_SUDO_QUIET"

  bl64_check_parameter 'sudoers' &&
    bl64_check_command "$BL64_RBAC_CMD_VISUDO" ||
    return $?

  bl64_dbg_lib_command_enabled && debug=' '

  # shellcheck disable=SC2086
  "$BL64_RBAC_CMD_VISUDO" \
    $debug \
    $BL64_RBAC_SET_SUDO_CHECK \
    ${BL64_RBAC_SET_SUDO_FILE}="$sudoers"
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
  local user="${1:-${BL64_VAR_NULL}}"
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
  local library="${1:-${BL64_VAR_NULL}}"
  local user="${2:-${BL64_VAR_NULL}}"
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
# BashLib64 / Module / Setup / Generate random data
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
function bl64_rnd_setup() {
  bl64_dbg_lib_show_function

  BL64_RND_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'rnd'
}

#######################################
# BashLib64 / Module / Functions / Generate random data
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

  _bl64_rxtx_set_command &&
    _bl64_rxtx_set_options &&
    _bl64_rxtx_set_alias &&
    BL64_RXTX_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'rxtx'
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
function _bl64_rxtx_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET='/usr/bin/wget'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_RXTX_CMD_CURL='/usr/bin/curl'
    BL64_RXTX_CMD_WGET="$BL64_VAR_INCOMPATIBLE"
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
function _bl64_rxtx_set_options() {
  bl64_dbg_lib_show_function
  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-20.* | ${BL64_OS_UB}-21.* | ${BL64_OS_UB}-22.* | ${BL64_OS_UB}-23.* | ${BL64_OS_DEB}-11.*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent --no-progress-meter'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    ;;
  ${BL64_OS_DEB}-9.* | ${BL64_OS_UB}-18.* | ${BL64_OS_DEB}-10.*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    ;;
  ${BL64_OS_FD}-*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent --no-progress-meter'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    ;;
  ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RXTX_SET_CURL_VERBOSE='--verbose'
    BL64_RXTX_SET_CURL_SILENT='--silent'
    BL64_RXTX_SET_CURL_OUTPUT='--output'
    BL64_RXTX_SET_CURL_SECURE='--config /dev/null'
    BL64_RXTX_SET_CURL_REDIRECT='--location'
    BL64_RXTX_SET_WGET_VERBOSE='--verbose'
    BL64_RXTX_SET_WGET_OUTPUT='--output-document'
    BL64_RXTX_SET_WGET_SECURE='--no-config'
    ;;
  ${BL64_OS_SLES}-*)
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
function _bl64_rxtx_set_alias() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_SLES}-*)
    BL64_RXTX_ALIAS_CURL="$BL64_RXTX_CMD_CURL ${BL64_RXTX_SET_CURL_SECURE}"
    BL64_RXTX_ALIAS_WGET="$BL64_RXTX_CMD_WGET ${BL64_RXTX_SET_WGET_SECURE}"
    ;;
  ${BL64_OS_ALP}-*)
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
#######################################

#######################################
# Pull data from web server
#
# * If the destination is already present no update is done unless $3=$BL64_VAR_ON
#
# Arguments:
#   $1: Source URL
#   $2: Full path to the destination file
#   $3: replace existing content Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
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
  local replace="${3:-${BL64_VAR_DEFAULT}}"
  local mode="${4:-${BL64_VAR_DEFAULT}}"
  local -i status=0

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_parameter 'source' &&
    bl64_check_parameter 'destination' || return $?

  [[ "$replace" == "$BL64_VAR_DEFAULT" ]] && replace="$BL64_VAR_OFF"
  [[ "$replace" == "$BL64_VAR_OFF" && -e "$destination" ]] &&
    bl64_dbg_lib_show_info "destination is already created (${destination}) and overwrite is disabled. No action taken" &&
    return 0
  bl64_fs_safeguard "$destination" >/dev/null || return $?

  bl64_msg_show_lib_subtask "$_BL64_RXTX_TXT_DOWNLOAD_FILE ($source)"
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
  if [[ "$status" == '0' && "$mode" != "$BL64_VAR_DEFAULT" ]]; then
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
# * If the destination is already present no update is done unless $4=$BL64_VAR_ON
# * If asked to replace destination, temporary backup is done in case git fails by moving the destination to a temp name
# * Warning: git repo info is removed after pull (.git)
#
# Arguments:
#   $1: URL to the GIT repository
#   $2: source path. Format: relative to the repo URL. Use '.' to download the full repo
#   $3: destination path. Format: full path
#   $4: replace existing content. Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
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
  local replace="${4:-${BL64_VAR_DEFAULT}}"
  local branch="${5:-main}"
  local -i status=0

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_parameter 'source_url' &&
    bl64_check_parameter 'source_path' &&
    bl64_check_parameter 'destination' &&
    bl64_check_path_relative "$source_path" ||
    return $?

  [[ "$replace" == "$BL64_VAR_DEFAULT" ]] && replace="$BL64_VAR_OFF"
  # shellcheck disable=SC2086
  bl64_check_overwrite "$destination" "$replace" "$_BL64_RXTX_TXT_EXISTING_DESTINATION" || return $BL64_VAR_OK

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

  bl64_check_module 'BL64_RXTX_MODULE' &&
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

  bl64_check_module 'BL64_RXTX_MODULE' &&
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

  bl64_check_module 'BL64_RXTX_MODULE' || return $?

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

  bl64_check_module 'BL64_RXTX_MODULE' || return $?

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
# Download asset from release in github repository
#
# Arguments:
#   $1: repo owner
#   $2: repo name
#   $3: release tag
#   $4: asset name
#   $5: replace existing content Values: $BL64_VAR_ON | $BL64_VAR_OFF (default)
#   $6: permissions. Regular chown format accepted. Default: umask defined
# Outputs:
#   STDOUT: none
#   STDERR: task error
# Returns:
#   0: success
#   >0: error
#######################################
function bl64_rxtx_github_get_asset() {
  bl64_dbg_lib_show_function "$@"
  local repo_owner="$1"
  local repo_name="$2"
  local release_tag="$3"
  local asset_name="$4"
  local destination="$5"
  local replace="${6:-${BL64_VAR_OFF}}"
  local mode="${7:-${BL64_VAR_DEFAULT}}"
  local -i status=0

  bl64_check_module 'BL64_RXTX_MODULE' &&
    bl64_check_parameter 'repo_owner' &&
    bl64_check_parameter 'repo_name' &&
    bl64_check_parameter 'release_tag' &&
    bl64_check_parameter 'asset_name' &&
    bl64_check_parameter 'destination' ||
  return $?

  bl64_rxtx_web_get_file \
    "https://github.com/${repo_owner}/${repo_name}/releases/download/${release_tag}/${asset_name}" \
    "$destination" "$replace" "$mode"
}

#######################################
# BashLib64 / Module / Setup / Manage date-time data
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
function bl64_tm_setup() {
  bl64_dbg_lib_show_function

  BL64_TM_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'tm'
}

#######################################
# BashLib64 / Module / Functions / Manage date-time data
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

  _bl64_txt_set_command &&
    _bl64_txt_set_options &&
    BL64_TXT_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'txt'
}

#######################################
# Identify and normalize common *nix OS commands
#
# * Commands are exported as variables with full path
# * For AWK the function will determine the best option to match posix awk
# * Warning: bootstrap function
# * AWS: provide legacy AWS, posix AWS and modern AWS when available
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
function _bl64_txt_set_command() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/bin/grep'
    BL64_TXT_CMD_SED='/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'

    if [[ -x '/usr/bin/gawk' ]]; then
      BL64_TXT_CMD_AWK_POSIX='/usr/bin/gawk'
    elif [[ -x '/usr/bin/mawk' ]]; then
      BL64_TXT_CMD_AWK_POSIX='/usr/bin/mawk'
    fi
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_AWK_POSIX='/usr/bin/gawk'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_TXT_CMD_AWK='/usr/bin/gawk'
    BL64_TXT_CMD_AWK_POSIX='/usr/bin/gawk'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_BASE64='/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/usr/bin/envsubst'
    BL64_TXT_CMD_GAWK='/usr/bin/gawk'
    BL64_TXT_CMD_GREP='/bin/grep'
    BL64_TXT_CMD_SED='/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'

    if [[ -x '/usr/bin/gawk' ]]; then
      BL64_TXT_CMD_AWK_POSIX='/usr/bin/gawk'
    fi
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_TXT_CMD_AWK='/usr/bin/awk'
    BL64_TXT_CMD_AWK_POSIX='/usr/bin/awk'
    BL64_TXT_CMD_BASE64='/usr/bin/base64'
    BL64_TXT_CMD_CUT='/usr/bin/cut'
    BL64_TXT_CMD_ENVSUBST='/opt/homebrew/bin/envsubst'
    BL64_TXT_CMD_GAWK="$BL64_VAR_INCOMPATIBLE"
    BL64_TXT_CMD_GREP='/usr/bin/grep'
    BL64_TXT_CMD_SED='/usr/bin/sed'
    BL64_TXT_CMD_SORT='/usr/bin/sort'
    BL64_TXT_CMD_TR='/usr/bin/tr'
    BL64_TXT_CMD_UNIQ='/usr/bin/uniq'
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
function _bl64_txt_set_options() {
  bl64_dbg_lib_show_function

  # shellcheck disable=SC2034
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='--quiet'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'

    if [[ -x '/usr/bin/gawk' ]]; then
      BL64_TXT_SET_AWK_POSIX='--posix'
    fi
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_TXT_SET_AWK_POSIX='--posix'
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='--quiet'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_TXT_SET_AWK_POSIX='--posix'
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='-q'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_TXT_SET_AWK_POSIX=''
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='-q'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    ;;
  ${BL64_OS_MCOS}-*)
    BL64_TXT_SET_AWK_POSIX=''
    BL64_TXT_SET_AWS_FS='-F'
    BL64_TXT_SET_GREP_ERE='-E'
    BL64_TXT_SET_GREP_INVERT='-v'
    BL64_TXT_SET_GREP_NO_CASE='-i'
    BL64_TXT_SET_GREP_QUIET='-q'
    BL64_TXT_SET_GREP_SHOW_FILE_ONLY='-l'
    ;;
  *) bl64_check_alert_unsupported ;;
  esac

}

#######################################
# BashLib64 / Module / Functions / Manipulate text files content
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
# Search for a whole line in a given text file or stdin
#
# Arguments:
#   $1: source file path. Use - for stdin
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

  bl64_txt_run_egrep "$BL64_TXT_SET_GREP_QUIET" "^${line}$" "$source"
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

  bl64_check_parameters_none "$#" ||
    return $?

  bl64_check_command "$BL64_TXT_CMD_AWK_POSIX" ||
    return $?

  bl64_dbg_lib_trace_start
  # shellcheck disable=SC2086
  "$BL64_TXT_CMD_AWK_POSIX" $BL64_TXT_SET_AWK_POSIX "$@"
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

  bl64_check_module 'BL64_TXT_MODULE' &&
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
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_GREP" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_GREP" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# Run grep with regular expression matching
#
# Arguments:
#   $@: arguments are passed as-is to the command
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_txt_run_egrep() {
  bl64_dbg_lib_show_function "$@"

  bl64_txt_run_grep "$BL64_TXT_SET_GREP_ERE" "$@"
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
    bl64_check_module 'BL64_TXT_MODULE' &&
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

  bl64_check_module 'BL64_TXT_MODULE' &&
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
    bl64_check_module 'BL64_TXT_MODULE' &&
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
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_CUT" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_CUT" "$@"
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
function bl64_txt_run_uniq() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_UNIQ" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_UNIQ" "$@"
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
function bl64_txt_run_sort() {
  bl64_dbg_lib_show_function "$@"

  bl64_check_parameters_none "$#" &&
    bl64_check_module 'BL64_TXT_MODULE' &&
    bl64_check_command "$BL64_TXT_CMD_SORT" ||
    return $?

  bl64_dbg_lib_trace_start
  "$BL64_TXT_CMD_SORT" "$@"
  bl64_dbg_lib_trace_stop
}

#######################################
# BashLib64 / Module / Setup / User Interface
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

  BL64_UI_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'ui'
}

#######################################
# BashLib64 / Module / Functions / User Interface
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
  bl64_dbg_lib_show_function "$@"
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

  _bl64_vcs_set_command &&
    _bl64_vcs_set_options &&
    BL64_VCS_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'vcs'
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
function _bl64_vcs_set_command() {
  bl64_dbg_lib_show_function
  case "$BL64_OS_DISTRO" in
  ${BL64_OS_UB}-* | ${BL64_OS_DEB}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
    ;;
  ${BL64_OS_FD}-* | ${BL64_OS_CNT}-* | ${BL64_OS_RHEL}-* | ${BL64_OS_ALM}-* | ${BL64_OS_OL}-* | ${BL64_OS_RCK}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
    ;;
  ${BL64_OS_SLES}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
    ;;
  ${BL64_OS_ALP}-*)
    BL64_VCS_CMD_GIT='/usr/bin/git'
    ;;
  ${BL64_OS_MCOS}-*)
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
function _bl64_vcs_set_options() {
  bl64_dbg_lib_show_function
  # Common sets - unversioned
  BL64_VCS_SET_GIT_NO_PAGER='--no-pager'
  BL64_VCS_SET_GIT_QUIET=' '
}

#######################################
# BashLib64 / Module / Functions / Manage Version Control System
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

  bl64_check_module 'BL64_VCS_MODULE' &&
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

  bl64_fs_create_dir "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "$destination" || return $?

  bl64_msg_show_lib_subtask "$_BL64_VCS_TXT_CLONE_REPO ($source)"

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

  bl64_fs_create_dir "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "${BL64_VAR_DEFAULT}" "$destination" || returnn $?

  # shellcheck disable=SC2164
  cd "$destination"

  bl64_dbg_lib_show_info 'detect if current git supports sparse-checkout option'
  if bl64_os_match "${BL64_OS_DEB}-9" "${BL64_OS_DEB}-10" "${BL64_OS_UB}-18" "${BL64_OS_UB}-20" "${BL64_OS_OL}-7" "${BL64_OS_CNT}-7"; then
    bl64_dbg_lib_show_info 'git sparse-checkout not supported. Using alternative method'
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
    bl64_dbg_lib_show_info 'git sparse-checkout is supported'
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
# GitHub / Call API
#
# Arguments:
#   $1: API URI and parameters
# Outputs:
#   STDOUT: command output
#   STDERR: command stderr
# Returns:
#   command exit status
#######################################
function bl64_vcs_github_run_api() {
  bl64_dbg_lib_show_function "$@"
  local api_call="$1"

  bl64_check_parameter 'api_call' ||
    return $?

  bl64_rxtx_run_curl \
    "$BL64_RXTX_SET_CURL_SILENT" \
    "${BL64_VCS_GITHUB_API_URL}/${api_call}"
}

#######################################
# GitHub / Get release number from latest release
#
# * Uses GitHub API
# * Assumes repo uses standard github release process which binds the latest release to a tag name representing the last version
# * Looks for pattern in json output: "tag_name": "xxxxx"
#
# Arguments:
#   $1: repo owner
#   $2: repo name
# Outputs:
#   STDOUT: release tag
#   STDERR: api error
# Returns:
#   0: api call success
#   >0: api call error
#######################################
function bl64_vcs_github_release_get_latest() {
  bl64_dbg_lib_show_function "$@"
  local repo_owner="$1"
  local repo_name="$2"
  local repo_tag=''

  bl64_check_parameter 'repo_owner' &&
    bl64_check_parameter 'repo_name' ||
    return $?

  # shellcheck disable=SC2086
  repo_tag="$(bl64_vcs_github_run_api \
    "repos/${repo_owner}/${repo_name}/releases/latest" |
    bl64_txt_run_awk -F: '/"tag_name": "/ {gsub(/[ ",]/,"", $2); print $2}')" &&
    [[ -n "$repo_tag" ]] &&
    echo "$repo_tag"
}

#######################################
# BashLib64 / Module / Setup / Manipulate CSV like text files
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
function bl64_xsv_setup() {
  bl64_dbg_lib_show_function

  BL64_XSV_MODULE="$BL64_VAR_ON"

  bl64_check_alert_module_setup 'xsv'
}

#######################################
# BashLib64 / Module / Functions / Manipulate CSV like text files
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

  bl64_txt_run_egrep "$BL64_TXT_SET_GREP_INVERT" '^#.*$|^$' "$source"

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
#######################################

#
# Library Bootstrap
#

# Normalize locales to C until a better locale is found in bl64_os_setup
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

# Initialize OS independant modules
bl64_dbg_setup &&
  bl64_check_setup &&
  bl64_msg_setup &&
  bl64_bsh_setup &&
  bl64_rnd_setup &&
  bl64_ui_setup ||
  return $?

# Initialize OS dependant modules
bl64_os_setup &&
  bl64_txt_setup &&
  bl64_fmt_setup &&
  bl64_fs_setup &&
  bl64_iam_setup &&
  bl64_rbac_setup &&
  bl64_vcs_setup &&
  bl64_rxtx_setup ||
  return $?

# Set signal handlers
# shellcheck disable=SC2064
if [[ "$BL64_LIB_TRAPS" == "$BL64_VAR_ON" ]]; then
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
if [[ "$BL64_LIB_CMD" == "$BL64_VAR_ON" ]]; then
  bl64_dbg_lib_show_info 'run bashlib64 in command mode'
  "$@"
else
  bl64_dbg_lib_show_info 'run bashlib64 in source mode'
  :
fi


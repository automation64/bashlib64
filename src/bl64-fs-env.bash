#######################################
# BashLib64 / Module / Globals / Manage local filesystem
#######################################

# shellcheck disable=SC2034
{
  declare BL64_FS_VERSION='5.2.0'

  declare BL64_FS_MODULE='0'

  declare BL64_FS_PATH_TEMPORAL=''
  declare BL64_FS_PATH_CACHE=''
  # Location for temporary files generated by bashlib64 functions
  declare BL64_FS_PATH_TMP='/tmp'

  declare BL64_FS_CMD_CHMOD=''
  declare BL64_FS_CMD_CHOWN=''
  declare BL64_FS_CMD_CP=''
  declare BL64_FS_CMD_FIND=''
  declare BL64_FS_CMD_LN=''
  declare BL64_FS_CMD_LS=''
  declare BL64_FS_CMD_MKDIR=''
  declare BL64_FS_CMD_MKTEMP=''
  declare BL64_FS_CMD_MV=''
  declare BL64_FS_CMD_RM=''
  declare BL64_FS_CMD_TOUCH=''

  declare BL64_FS_ALIAS_CHOWN_DIR=''
  declare BL64_FS_ALIAS_CP_FILE=''
  declare BL64_FS_ALIAS_LN_SYMBOLIC=''
  declare BL64_FS_ALIAS_LS_FILES=''
  declare BL64_FS_ALIAS_MKDIR_FULL=''
  declare BL64_FS_ALIAS_MV=''
  declare BL64_FS_ALIAS_RM_FILE=''
  declare BL64_FS_ALIAS_RM_FULL=''

  declare BL64_FS_SET_CHMOD_RECURSIVE=''
  declare BL64_FS_SET_CHMOD_VERBOSE=''
  declare BL64_FS_SET_CHOWN_RECURSIVE=''
  declare BL64_FS_SET_CHOWN_VERBOSE=''
  declare BL64_FS_SET_CP_FORCE=''
  declare BL64_FS_SET_CP_RECURSIVE=''
  declare BL64_FS_SET_CP_VERBOSE=''
  declare BL64_FS_SET_FIND_NAME=''
  declare BL64_FS_SET_FIND_PRINT=''
  declare BL64_FS_SET_FIND_RUN=''
  declare BL64_FS_SET_FIND_STAY=''
  declare BL64_FS_SET_FIND_TYPE_DIR=''
  declare BL64_FS_SET_FIND_TYPE_FILE=''
  declare BL64_FS_SET_LN_FORCE=''
  declare BL64_FS_SET_LN_SYMBOLIC=''
  declare BL64_FS_SET_LN_VERBOSE=''
  declare BL64_FS_SET_LS_NOCOLOR=''
  declare BL64_FS_SET_MKDIR_PARENTS=''
  declare BL64_FS_SET_MKDIR_VERBOSE=''
  declare BL64_FS_SET_MKTEMP_DIRECTORY=''
  declare BL64_FS_SET_MKTEMP_QUIET=''
  declare BL64_FS_SET_MKTEMP_TMPDIR=''
  declare BL64_FS_SET_MV_FORCE=''
  declare BL64_FS_SET_MV_VERBOSE=''
  declare BL64_FS_SET_RM_FORCE=''
  declare BL64_FS_SET_RM_RECURSIVE=''
  declare BL64_FS_SET_RM_VERBOSE=''

  #
  # File permission modes
  #
  # shellcheck disable=SC2034
  declare BL64_FS_UMASK_RW_USER='u=rwx,g=,o='
  declare BL64_FS_UMASK_RW_GROUP='u=rwx,g=rwx,o='
  declare BL64_FS_UMASK_RW_ALL='u=rwx,g=rwx,o=rwx'
  declare BL64_FS_UMASK_RW_USER_RO_ALL='u=rwx,g=rx,o=rx'
  declare BL64_FS_UMASK_RW_GROUP_RO_ALL='u=rwx,g=rwx,o=rx'

  declare BL64_FS_SAFEGUARD_POSTFIX='.bl64_fs_safeguard'

  declare BL64_FS_TMP_PREFIX='bl64tmp'

  declare _BL64_FS_TXT_CLEANUP_CACHES='clean up OS cache contents'
  declare _BL64_FS_TXT_CLEANUP_LOGS='clean up OS logs'
  declare _BL64_FS_TXT_CLEANUP_TEMP='clean up OS temporary files'
  declare _BL64_FS_TXT_COPY_FILE_PATH='copy file'
  declare _BL64_FS_TXT_CREATE_DIR_PATH='create directory'
  declare _BL64_FS_TXT_MERGE_ADD_SOURCE='merge content from source'
  declare _BL64_FS_TXT_MERGE_DIRS='merge directories content'
  declare _BL64_FS_TXT_RESTORE_OBJECT='restore original file from backup'
  declare _BL64_FS_TXT_SAFEGUARD_FAILED='unable to safeguard requested path'
  declare _BL64_FS_TXT_SAFEGUARD_OBJECT='backup original file'
  declare _BL64_FS_TXT_SYMLINK_CREATE='create symbolick link'
  declare _BL64_FS_TXT_SYMLINK_EXISTING='target symbolick link is already present. No further action taken'
  declare _BL64_FS_TXT_CREATE_FILE='create empty regular file'
  declare _BL64_FS_TXT_UMASK_SET='temporary change current script umask'
  declare _BL64_FS_TXT_FIX_FILE_PERMS='recursively fix file permissions'
  declare _BL64_FS_TXT_FIX_DIR_PERMS='recursively fix directory permissions'

  declare _BL64_FS_TXT_WARN_EXISTING_FILE='target file is already created'
  declare _BL64_FS_TXT_ERROR_NOT_TMPDIR='provided directory was not created by bl64_fs_create_tmpdir'
  declare _BL64_FS_TXT_ERROR_NOT_TMPFILE='provided directory was not created by bl64_fs_create_tmpfile'
  declare _BL64_FS_TXT_ERROR_INVALID_FILE_TARGET='invalid file destination. Provided path exists and is a directory'
  declare _BL64_FS_TXT_ERROR_INVALID_DIR_TARGET='invalid directory destination. Provided path exists and is a file'

  declare _BL64_FS_TXT_SET_MODE='set new file permissions'
  declare _BL64_FS_TXT_SET_OWNER='set new file owner'
  declare _BL64_FS_TXT_SET_GROUP='set new file group'
}

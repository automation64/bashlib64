setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_lib_env: global flags are set" {
  assert_not_equal "$BL64_LIB_CMD" ''
  assert_not_equal "$BL64_LIB_LANG" ''
  assert_not_equal "$BL64_LIB_STRICT" ''
  assert_not_equal "$BL64_LIB_TRAPS" ''
}

@test "bl64_lib_env: public constants are set" {
  assert_equal "$BL64_LIB_DEFAULT" '_'
  assert_equal "$BL64_LIB_INCOMPATIBLE" '_INC_'
  assert_equal "$BL64_LIB_UNAVAILABLE" '_UNV_'
  assert_equal "$BL64_LIB_VAR_FALSE" '1'
  assert_equal "$BL64_LIB_VAR_NULL" '__'
  assert_equal "$BL64_LIB_VAR_OFF" '0'
  assert_equal "$BL64_LIB_VAR_OK" '0'
  assert_equal "$BL64_LIB_VAR_ON" '1'
  assert_equal "$BL64_LIB_VAR_TRUE" '0'
}

@test "bl64_lib_env: error constants are set" {

  assert_equal $BL64_LIB_ERROR_PARAMETER_INVALID 3
  assert_equal $BL64_LIB_ERROR_PARAMETER_MISSING 4
  assert_equal $BL64_LIB_ERROR_PARAMETER_RANGE 5
  assert_equal $BL64_LIB_ERROR_PARAMETER_EMPTY 6

  assert_equal $BL64_LIB_ERROR_TASK_FAILED 10
  assert_equal $BL64_LIB_ERROR_TASK_BACKUP 11
  assert_equal $BL64_LIB_ERROR_TASK_RESTORE 12
  assert_equal $BL64_LIB_ERROR_TASK_TEMP 13
  assert_equal $BL64_LIB_ERROR_TASK_UNDEFINED 14

  assert_equal $BL64_LIB_ERROR_MODULE_SETUP_INVALID 20
  assert_equal $BL64_LIB_ERROR_MODULE_SETUP_MISSING 21

  assert_equal $BL64_LIB_ERROR_OS_NOT_MATCH 30
  assert_equal $BL64_LIB_ERROR_OS_TAG_INVALID 31
  assert_equal $BL64_LIB_ERROR_OS_INCOMPATIBLE 32
  assert_equal $BL64_LIB_ERROR_OS_BASH_VERSION 33

  assert_equal $BL64_LIB_ERROR_APP_INCOMPATIBLE 40
  assert_equal $BL64_LIB_ERROR_APP_MISSING 41

  assert_equal $BL64_LIB_ERROR_FILE_NOT_FOUND 50
  assert_equal $BL64_LIB_ERROR_FILE_NOT_READ 51
  assert_equal $BL64_LIB_ERROR_FILE_NOT_EXECUTE 52
  assert_equal $BL64_LIB_ERROR_DIRECTORY_NOT_FOUND 53
  assert_equal $BL64_LIB_ERROR_DIRECTORY_NOT_READ 54
  assert_equal $BL64_LIB_ERROR_PATH_NOT_RELATIVE 55
  assert_equal $BL64_LIB_ERROR_PATH_NOT_ABSOLUTE 56
  assert_equal $BL64_LIB_ERROR_PATH_NOT_FOUND 57
  assert_equal $BL64_LIB_ERROR_PATH_PRESENT 58

  assert_equal $BL64_LIB_ERROR_PRIVILEGE_IS_ROOT 60
  assert_equal $BL64_LIB_ERROR_PRIVILEGE_IS_NOT_ROOT 61
  assert_equal $BL64_LIB_ERROR_USER_NOT_FOUND 62
#  assert_equal $BL64_LIB_ERROR_GROUP_NOT_FOUND 63

  assert_equal $BL64_LIB_ERROR_EXPORT_EMPTY 70
  assert_equal $BL64_LIB_ERROR_EXPORT_SET 71
  assert_equal $BL64_LIB_ERROR_OVERWRITE_NOT_PERMITED 72

}

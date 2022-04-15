setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_check_env: public constants are set" {

  assert_equal $BL64_CHECK_ERROR_MISSING_PARAMETER 1
  assert_equal $BL64_CHECK_ERROR_FILE_NOT_FOUND 2
  assert_equal $BL64_CHECK_ERROR_FILE_NOT_READ 3
  assert_equal $BL64_CHECK_ERROR_FILE_NOT_EXECUTE 4
  assert_equal $BL64_CHECK_ERROR_DIRECTORY_NOT_FOUND 5
  assert_equal $BL64_CHECK_ERROR_DIRECTORY_NOT_READ 6
  assert_equal $BL64_CHECK_ERROR_PARAMETER_EMPTY 7
  assert_equal $BL64_CHECK_ERROR_EXPORT_EMPTY 8
  assert_equal $BL64_CHECK_ERROR_EXPORT_SET 9
  assert_equal $BL64_CHECK_ERROR_PATH_NOT_RELATIVE 10
  assert_equal $BL64_CHECK_ERROR_PATH_NOT_ABSOLUTE 11

}
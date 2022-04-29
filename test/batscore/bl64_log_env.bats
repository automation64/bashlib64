setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_log_env: public constants are set" {

  assert_equal "$BL64_LOG_TYPE_FILE" 'F'
  assert_equal "$BL64_LOG_CATEGORY_INFO" 'info'
  assert_equal "$BL64_LOG_CATEGORY_TASK" 'task'
  assert_equal "$BL64_LOG_CATEGORY_DEBUG" 'debug'
  assert_equal "$BL64_LOG_CATEGORY_WARNING" 'warning'
  assert_equal "$BL64_LOG_CATEGORY_ERROR" 'error'
  assert_equal "$BL64_LOG_CATEGORY_RECORD" 'record'

  assert_equal $BL64_LOG_ERROR_INVALID_TYPE 201
  assert_equal $BL64_LOG_ERROR_INVALID_VERBOSE 202
  assert_equal $BL64_LOG_ERROR_NOT_SETUP 203

}

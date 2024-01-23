setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_log_env: public constants are set" {
  assert_equal "$BL64_LOG_FORMAT_CSV" 'C'

  assert_equal "$BL64_LOG_CATEGORY_NONE" 'NONE'
  assert_equal "$BL64_LOG_CATEGORY_INFO" 'INFO'
  assert_equal "$BL64_LOG_CATEGORY_DEBUG" 'DEBUG'
  assert_equal "$BL64_LOG_CATEGORY_WARNING" 'WARNING'
  assert_equal "$BL64_LOG_CATEGORY_ERROR" 'ERROR'
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_cnt_setup || skip 'no container CLI found'
}

@test "_bl64_cnt_set_options: common globals are set" {
  assert_not_equal "$BL64_CNT_SET_FILTER" ''
  assert_not_equal "$BL64_CNT_SET_DEBUG" ''
  assert_not_equal "$BL64_CNT_SET_ENTRYPOINT" ''
  assert_not_equal "$BL64_CNT_SET_FILE" ''
  assert_not_equal "$BL64_CNT_SET_FILTER" ''
  assert_not_equal "$BL64_CNT_SET_INTERACTIVE" ''
  assert_not_equal "$BL64_CNT_SET_LOG_LEVEL" ''
  assert_not_equal "$BL64_CNT_SET_NO_CACHE" ''
  assert_not_equal "$BL64_CNT_SET_PASSWORD_STDIN" ''
  assert_not_equal "$BL64_CNT_SET_PASSWORD" ''
  assert_not_equal "$BL64_CNT_SET_PROGRESS" ''
  assert_not_equal "$BL64_CNT_SET_QUIET" ''
  assert_not_equal "$BL64_CNT_SET_RM" ''
  assert_not_equal "$BL64_CNT_SET_TAG" ''
  assert_not_equal "$BL64_CNT_SET_TTY" ''
  assert_not_equal "$BL64_CNT_SET_USERNAME" ''
  assert_not_equal "$BL64_CNT_SET_VERSION" ''

  assert_not_equal "$BL64_CNT_SET_FILTER_ID" ''
  assert_not_equal "$BL64_CNT_SET_FILTER_NAME" ''
  assert_not_equal "$BL64_CNT_SET_LOG_LEVEL_DEBUG" ''
  assert_not_equal "$BL64_CNT_SET_LOG_LEVEL_ERROR" ''
  assert_not_equal "$BL64_CNT_SET_LOG_LEVEL_INFO" ''
  assert_not_equal "$BL64_CNT_SET_PROGRESS_PLAIN" ''
  assert_not_equal "$BL64_CNT_SET_PROGRESS_TTY" ''
  assert_not_equal "$BL64_CNT_SET_STATUS_RUNNING" ''
}

@test "bl64_msg_env: public constants are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  assert_equal "$BL64_MSG_FORMAT_PLAIN" 'PLAIN'
  assert_equal "$BL64_MSG_FORMAT_HOST" 'HOST'
  assert_equal "$BL64_MSG_FORMAT_TIME" 'TIME'
  assert_equal "$BL64_MSG_FORMAT_CALLER" 'CALLER'
  assert_equal "$BL64_MSG_FORMAT_FULL" 'FULL'

  assert_equal "$BL64_MSG_VERBOSE_NONE" 'NONE'
  assert_equal "$BL64_MSG_VERBOSE_APP" 'APP'
  assert_equal "$BL64_MSG_VERBOSE_LIB" 'LIB'
  assert_equal "$BL64_MSG_VERBOSE_ALL" 'ALL'

  assert_not_equal "$BL64_MSG_FORMAT" ''

}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_msg_env: public constants are set" {

  assert_equal "$BL64_MSG_FORMAT_PLAIN" 'R'
  assert_equal "$BL64_MSG_FORMAT_HOST" 'H'
  assert_equal "$BL64_MSG_FORMAT_TIME" 'T'
  assert_equal "$BL64_MSG_FORMAT_CALLER" 'C'
  assert_equal "$BL64_MSG_FORMAT_FULL" 'F'

  assert_equal "$BL64_MSG_VERBOSE_NONE" 'NONE'
  assert_equal "$BL64_MSG_VERBOSE_APP" 'APP'
  assert_equal "$BL64_MSG_VERBOSE_LIB" 'LIB'
  assert_equal "$BL64_MSG_VERBOSE_ALL" 'ALL'

  assert_not_equal "$BL64_MSG_FORMAT" ''

}

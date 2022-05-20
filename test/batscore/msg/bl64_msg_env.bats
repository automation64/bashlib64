setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_msg_env: public constants are set" {

  assert_equal "$BL64_MSG_FORMAT_PLAIN" 'R'
  assert_equal "$BL64_MSG_FORMAT_HOST" 'H'
  assert_equal "$BL64_MSG_FORMAT_TIME" 'T'
  assert_equal "$BL64_MSG_FORMAT_CALLER" 'C'
  assert_equal "$BL64_MSG_FORMAT_FULL" 'F'

  assert_equal "$BL64_MSG_VERBOSE_NONE" '0'
  assert_equal "$BL64_MSG_VERBOSE_APP" '1'
  assert_equal "$BL64_MSG_VERBOSE_LIB" '2'

  assert_not_equal "$BL64_MSG_FORMAT" ''

}

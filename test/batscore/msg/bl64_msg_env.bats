setup() {
  . "$DEVBL_TEST_SETUP"

}

@test "bl64_msg_env: public constants are set" {

  assert_equal "$BL64_MSG_FORMAT_PLAIN" 'R'
  assert_equal "$BL64_MSG_FORMAT_HOST" 'H'
  assert_equal "$BL64_MSG_FORMAT_TIME" 'T'
  assert_equal "$BL64_MSG_FORMAT_CALLER" 'C'
  assert_equal "$BL64_MSG_FORMAT_FULL" 'F'

}

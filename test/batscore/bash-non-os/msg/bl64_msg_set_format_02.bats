@test "bl64_msg_set_format: set format" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_format "$BL64_MSG_FORMAT_CALLER"
  assert_success

}

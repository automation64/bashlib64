@test "bl64_msg_set_output: set ascii" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_output "$BL64_MSG_OUTPUT_ASCII"
  assert_success

}

@test "bl64_msg_set_output: set ansi" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_output "$BL64_MSG_OUTPUT_ANSI"
  assert_success

}

@test "bl64_msg_set_output: set emoji" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_output "$BL64_MSG_OUTPUT_EMOJI"
  assert_success

}

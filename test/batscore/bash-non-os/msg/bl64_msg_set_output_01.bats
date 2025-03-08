@test "bl64_msg_set_output: invalid arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_output 'NOT_VALID'
  assert_failure

}

@test "bl64_msg_set_output: set ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_output "$BL64_MSG_OUTPUT_ASCII"
  assert_success

}

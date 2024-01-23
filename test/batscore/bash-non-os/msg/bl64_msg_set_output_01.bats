@test "bl64_msg_set_output: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_output
  assert_failure

}

@test "bl64_msg_set_output: invalid arg" {

  run bl64_msg_set_output 'NOT_VALID'
  assert_failure

}

@test "bl64_msg_set_output: set ok" {

  run bl64_msg_set_output "$BL64_MSG_OUTPUT_ASCII"
  assert_success

}

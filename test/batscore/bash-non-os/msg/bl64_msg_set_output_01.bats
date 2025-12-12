@test "bl64_msg_set_output: invalid arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_output 'NOT_VALID'
  assert_failure

}

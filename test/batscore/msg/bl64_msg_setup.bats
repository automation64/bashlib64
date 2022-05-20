setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_msg_setup: missing format" {

  run bl64_msg_setup
  assert_failure

}

@test "bl64_msg_setup: invalid format" {

  run bl64_msg_setup 'NOT_VALID'
  assert_failure

}

@test "bl64_msg_setup: set format" {

  run bl64_msg_setup "$BL64_MSG_FORMAT_CALLER"
  assert_success

}

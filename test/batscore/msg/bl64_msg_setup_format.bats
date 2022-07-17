setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_msg_setup_format: missing format" {

  run bl64_msg_setup_format
  assert_failure

}

@test "bl64_msg_setup_format: invalid format" {

  run bl64_msg_setup_format 'NOT_VALID'
  assert_failure

}

@test "bl64_msg_setup_format: set format" {

  run bl64_msg_setup_format "$BL64_MSG_FORMAT_CALLER"
  assert_success

}

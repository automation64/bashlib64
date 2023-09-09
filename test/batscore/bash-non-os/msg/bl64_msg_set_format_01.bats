setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_msg_set_format: missing format" {

  run bl64_msg_set_format
  assert_failure

}

@test "bl64_msg_set_format: invalid format" {

  run bl64_msg_set_format 'NOT_VALID'
  assert_failure

}

@test "bl64_msg_set_format: set format" {

  run bl64_msg_set_format "$BL64_MSG_FORMAT_CALLER"
  assert_success

}

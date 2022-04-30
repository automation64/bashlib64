setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_msg_setup: missing format" {

  run bl64_msg_setup
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_MODULE_SETUP_INVALID

}

@test "bl64_msg_setup: invalid format" {

  run bl64_msg_setup 'NOT_VALID'
  assert_failure
  assert_equal "$status" $BL64_LIB_ERROR_MODULE_SETUP_INVALID

}

@test "bl64_msg_setup: set format" {

  run bl64_msg_setup "$BL64_MSG_FORMAT_CALLER"
  assert_success

}

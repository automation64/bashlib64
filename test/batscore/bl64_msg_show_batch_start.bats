setup() {
  . "$DEVBL_TEST_SETUP"

  bl64_msg_setup "$BL64_MSG_FORMAT_FULL"
}

@test "bl64_msg_show_task: output" {
  local value='testing batch msg'

  run bl64_msg_show_batch_start "$value"

  assert_success
}

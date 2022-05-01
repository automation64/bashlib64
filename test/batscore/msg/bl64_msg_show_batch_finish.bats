setup() {
  . "$DEVBL_TEST_SETUP"

  bl64_msg_setup "$BL64_MSG_FORMAT_FULL"
}

@test "bl64_msg_show_batch_finish: ok" {
  local value='testing batch msg'
  local finish=0

  run bl64_msg_show_batch_finish $finish "$value"

  assert_success
}

@test "bl64_msg_show_batch_finish: error" {
  local value='testing batch msg'
  local finish=10

  run bl64_msg_show_batch_finish $finish "$value"

  assert_success
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_msg_set_format "$BL64_MSG_FORMAT_FULL"
}

@test "bl64_msg_show_task: output" {
  local value='testing task msg'
  bl64_dbg_lib_msg_enable
  bl64_dbg_lib_enable
  run bl64_msg_show_task "$value"
  assert_success
  assert_output --partial "$value"
}

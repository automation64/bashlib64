@test "bl64_msg_show_task: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing task msg'
  _bl64_dbg_lib_msg_enable
  bl64_dbg_lib_enable
  run bl64_msg_show_task "$value"
  assert_success
  assert_output --partial "$value"
}

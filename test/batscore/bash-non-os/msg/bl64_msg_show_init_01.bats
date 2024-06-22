@test "bl64_msg_show_init: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing init msg'

  run bl64_msg_show_init "$value"
  assert_success
  assert_output --partial "$value"
}

@test "bl64_msg_show_warning: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing task msg'

  run bl64_msg_show_warning "$value"
  assert_success
  assert_output --partial "$value"
}

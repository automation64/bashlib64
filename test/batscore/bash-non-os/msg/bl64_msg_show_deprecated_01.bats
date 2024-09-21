@test "bl64_msg_show_deprecated: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing task msg'

  run bl64_msg_show_deprecated "$value"
  assert_success
  assert_output --partial "$value"
}

@test "bl64_msg_show_deprecated: output 2" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='replacement'

  run bl64_msg_show_deprecated 'test' "$value"
  assert_success
  assert_output --partial "$value"
}

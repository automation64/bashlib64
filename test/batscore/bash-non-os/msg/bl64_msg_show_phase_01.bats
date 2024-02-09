@test "bl64_msg_show_phase: output" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing phase msg'

  run bl64_msg_show_phase "$value"
  assert_success
  assert_output --partial "$value"
}

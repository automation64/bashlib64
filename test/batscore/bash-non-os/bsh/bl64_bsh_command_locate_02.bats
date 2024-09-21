@test "bl64_bsh_command_locate: command ok - no path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate bash
  assert_success
}

@test "bl64_bsh_command_locate: command not ok - no path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate bashx
  assert_success
}

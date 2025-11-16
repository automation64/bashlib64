@test "bl64_bsh_command_import: command found - no path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_import bash
  assert_success
}

@test "bl64_bsh_command_import: command not found - no path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_import bashx
  assert_success
}

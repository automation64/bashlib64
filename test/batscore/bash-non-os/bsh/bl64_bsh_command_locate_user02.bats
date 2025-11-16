@test "bl64_bsh_command_locate_user: command ok - no path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate_user bash
  assert_success
}

@test "bl64_bsh_command_locate_user: command not ok - no path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate_user bashx
  assert_success
}

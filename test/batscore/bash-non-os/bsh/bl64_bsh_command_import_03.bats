@test "bl64_bsh_command_import: command found - extra path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_import bash /opt
  assert_success
}

@test "bl64_bsh_command_import: command not found - extra path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_import bashx /opt
  assert_success
}

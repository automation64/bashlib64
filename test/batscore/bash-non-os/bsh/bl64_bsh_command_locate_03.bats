@test "bl64_bsh_command_locate: command found - extra path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate bash /opt
  assert_success
}

@test "bl64_bsh_command_locate: command not found - extra path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate bashx /opt
  assert_success
}

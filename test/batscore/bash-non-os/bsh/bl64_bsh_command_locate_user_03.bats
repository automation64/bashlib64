@test "bl64_bsh_command_locate_user: command ok - extra path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate_user bash /opt
  assert_success
}

@test "bl64_bsh_command_locate_user: command not ok - extra path" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate_user bashx /opt
  assert_failure
}

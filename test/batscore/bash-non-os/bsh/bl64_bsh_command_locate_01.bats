@test "bl64_bsh_command_locate: no arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_locate
  assert_failure
}

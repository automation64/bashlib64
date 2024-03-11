@test "bl64_bsh_command_get_path: no arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_get_path
  assert_failure
}

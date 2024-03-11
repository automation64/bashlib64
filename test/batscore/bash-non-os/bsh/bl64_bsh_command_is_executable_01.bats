@test "bl64_bsh_command_is_executable: no arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_command_is_executable
  assert_failure
}

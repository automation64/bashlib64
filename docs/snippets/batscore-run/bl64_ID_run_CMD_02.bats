@test "bl64_X_MODULE_X_run_X_COMMAND_X: command run" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_X_MODULE_X_run_X_COMMAND_X --help
  assert_success
}

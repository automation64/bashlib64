@test "bl64_check_command: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_command
  assert_failure

}

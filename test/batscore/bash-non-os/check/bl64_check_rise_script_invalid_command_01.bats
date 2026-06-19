@test "bl64_check_rise_script_invalid_command: rise error" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_rise_script_invalid_command
  assert_failure
}

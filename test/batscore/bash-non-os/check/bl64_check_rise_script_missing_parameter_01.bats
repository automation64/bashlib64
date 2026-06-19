@test "bl64_check_rise_script_missing_parameter: rise error" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_rise_script_missing_parameter
  assert_failure
}

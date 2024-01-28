@test "bl64_check_alert_parameter_invalid: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_alert_parameter_invalid
  assert_failure

}

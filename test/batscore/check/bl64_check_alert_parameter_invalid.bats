setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_alert_parameter_invalid: parameter is not present" {

  run bl64_check_alert_parameter_invalid
  assert_failure

}

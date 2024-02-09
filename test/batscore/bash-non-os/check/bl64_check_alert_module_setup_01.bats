@test "bl64_check_alert_module_setup: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_alert_module_setup
  assert_failure

}

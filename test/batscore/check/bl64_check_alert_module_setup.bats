setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_alert_module_setup: parameter is not present" {

  run bl64_check_alert_module_setup
  assert_failure

}

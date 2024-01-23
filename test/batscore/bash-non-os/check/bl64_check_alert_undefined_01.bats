@test "bl64_check_alert_undefined: execution" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_alert_undefined
  assert_failure

}

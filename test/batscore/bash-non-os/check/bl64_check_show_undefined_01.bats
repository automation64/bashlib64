@test "bl64_check_alert_undefined: syntax" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_alert_undefined 'test'
  assert_failure
}

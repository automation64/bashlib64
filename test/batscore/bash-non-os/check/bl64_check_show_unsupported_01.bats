@test "bl64_check_alert_unsupported: syntax" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_alert_unsupported 'test'
  assert_failure
}

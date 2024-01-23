@test "bl64_check_alert_unsupported: execution" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_check_alert_unsupported
  assert_failure

}

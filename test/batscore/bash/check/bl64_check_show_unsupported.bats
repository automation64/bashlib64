setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_check_alert_unsupported: syntax" {

  run bl64_check_alert_unsupported 'test'
  assert_failure
}

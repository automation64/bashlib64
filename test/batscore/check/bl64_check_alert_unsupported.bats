setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_alert_unsupported: parameter is not present" {

  run bl64_check_alert_unsupported
  assert_failure

}

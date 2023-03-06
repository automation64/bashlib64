setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_alert_unsupported: execution" {

  run bl64_check_alert_unsupported
  assert_failure

}

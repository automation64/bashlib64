setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_alert_undefined: execution" {

  run bl64_check_alert_undefined
  assert_failure

}

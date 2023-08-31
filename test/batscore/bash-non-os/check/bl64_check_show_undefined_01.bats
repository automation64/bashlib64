setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "bl64_check_alert_undefined: syntax" {

  run bl64_check_alert_undefined 'test'
  assert_failure
}

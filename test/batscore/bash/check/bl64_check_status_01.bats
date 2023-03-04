setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_status: parameter is not present" {
  run bl64_check_status
  assert_failure
}

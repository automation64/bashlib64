@test "bl64_check_status: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_check_status
  assert_failure
}

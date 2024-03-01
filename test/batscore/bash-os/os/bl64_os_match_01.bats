@test "bl64_os_match: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_os_match
  assert_failure
}

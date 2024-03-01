@test "bl64_os_check_compatibility: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_os_check_compatibility
  assert_failure
}

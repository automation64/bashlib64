@test "bl64_os_run_sleep: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_os_run_sleep
  assert_failure
}

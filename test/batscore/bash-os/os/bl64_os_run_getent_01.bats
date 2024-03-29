@test "bl64_os_run_getent: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_os_run_getent
  assert_failure
}

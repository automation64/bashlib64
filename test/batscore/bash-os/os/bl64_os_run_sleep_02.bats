@test "bl64_os_run_sleep: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_os_run_sleep 1
  assert_success
}

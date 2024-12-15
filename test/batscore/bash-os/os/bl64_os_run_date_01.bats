@test "bl64_os_run_date: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_os_run_date
  assert_success
}

@test "bl64_os_run_getent: command run" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_os_run_getent --help
  assert_success
}

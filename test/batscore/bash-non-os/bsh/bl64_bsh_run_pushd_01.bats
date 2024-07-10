@test "bl64_bsh_run_pushd: run commmand ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_run_pushd /tmp
  assert_success
}

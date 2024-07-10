@test "bl64_bsh_run_popd: run commmand ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_bsh_run_pushd /tmp
  run bl64_bsh_run_popd
  assert_success
}

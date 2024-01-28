@test "bl64_dbg_runtime_show_paths: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_dbg_runtime_show_paths
  assert_success
}
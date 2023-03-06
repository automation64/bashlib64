setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_dbg_runtime_show_paths: run ok" {
  run bl64_dbg_runtime_show_paths
  assert_success
}
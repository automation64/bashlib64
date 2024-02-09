@test "bl64_dbg_runtime_show_bashlib64: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_dbg_runtime_show_bashlib64
  assert_success
}
@test "bl64_dbg_runtime_show_callstack: run" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_dbg_runtime_show_callstack

  assert_success

}

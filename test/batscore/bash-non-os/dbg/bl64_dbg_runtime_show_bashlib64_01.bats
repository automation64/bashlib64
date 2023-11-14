setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_dbg_runtime_show_bashlib64: run ok" {
  run bl64_dbg_runtime_show_bashlib64
  assert_success
}
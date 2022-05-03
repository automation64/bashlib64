setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_dbg_runtime_show_callstack: run" {

  run bl64_dbg_runtime_show_callstack

  assert_success

}

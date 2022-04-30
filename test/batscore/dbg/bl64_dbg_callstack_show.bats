setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_dbg_callstack_show: run" {

  true
  run bl64_dbg_callstack_show

  assert_success

}

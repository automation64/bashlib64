setup() {
  . "$DEVBL_TEST_SETUP"
}

function _test_bl64_dbg_app_trace_start() {
  bl64_dbg_app_trace_start
}

@test "bl64_dbg_app_trace_start: start dbg" {

  run _test_bl64_dbg_app_trace_start

  assert_success

}

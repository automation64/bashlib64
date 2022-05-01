setup() {
  . "$DEVBL_TEST_SETUP"
}

function _test_bl64_dbg_lib_trace_stop() {
  bl64_dbg_lib_trace_stop
}

@test "bl64_dbg_lib_trace_stop: start dbg" {

  run _test_bl64_dbg_lib_trace_stop

  assert_success

}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_dbg_lib_trace_stop() {
  true
  bl64_dbg_lib_trace_stop
}

@test "bl64_dbg_lib_trace_stop: stop dbg" {

  run _test_bl64_dbg_lib_trace_stop

  assert_success

}

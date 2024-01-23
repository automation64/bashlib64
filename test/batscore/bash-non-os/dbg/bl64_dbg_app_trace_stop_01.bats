function _test_bl64_dbg_app_trace_stop() {
  true
  bl64_dbg_app_trace_stop
}

@test "bl64_dbg_app_trace_stop: stop dbg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run _test_bl64_dbg_app_trace_stop

  assert_success

}

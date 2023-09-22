setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_dbg_app_show_function() {
  bl64_dbg_app_show_function "$@"
}

@test "bl64_dbg_app_show_function: show function" {

  run _test_bl64_dbg_app_show_function

  assert_success

}

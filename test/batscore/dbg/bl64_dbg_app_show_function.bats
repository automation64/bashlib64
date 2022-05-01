setup() {
  . "$DEVBL_TEST_SETUP"
}

function _test_bl64_dbg_app_show_function() {
  bl64_dbg_app_show_function "$@"
}

@test "bl64_dbg_app_show_function: start dbg" {

  run _test_bl64_dbg_app_show_function

  assert_success

}

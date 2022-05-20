setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_dbg_lib_show_function() {
  bl64_dbg_lib_show_function "$@"
}

@test "bl64_dbg_lib_show_function: start dbg" {

  run _test_bl64_dbg_lib_show_function

  assert_success

}

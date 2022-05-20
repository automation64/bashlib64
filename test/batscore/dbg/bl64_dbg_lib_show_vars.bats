setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_dbg_lib_show_vars() {
  export TEST_VAR=123
  bl64_dbg_lib_show_vars 'TEST_VAR'
}

@test "bl64_dbg_lib_show_vars: start dbg" {

  run _test_bl64_dbg_lib_show_vars

  assert_success

}

setup() {
  . "$DEVBL_TEST_SETUP"
}

function _test_bl64_dbg_lib_show_info() {
  bl64_dbg_lib_show_info 'TEST_VAR=1'
}

@test "bl64_dbg_lib_show_info: start dbg" {

  run _test_bl64_dbg_lib_show_info

  assert_success

}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_dbg_lib_show_comments() {
  bl64_dbg_lib_show_comments 'TEST'
}

@test "bl64_dbg_lib_show_comments: show comments" {

  run _test_bl64_dbg_lib_show_comments

  assert_success

}

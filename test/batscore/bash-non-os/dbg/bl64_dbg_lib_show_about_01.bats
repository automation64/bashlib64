function _test_bl64_dbg_lib_show_about() {
  bl64_dbg_lib_show_about 'TEST'
}

@test "bl64_dbg_lib_show_about: show comments" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run _test_bl64_dbg_lib_show_about

  assert_success

}

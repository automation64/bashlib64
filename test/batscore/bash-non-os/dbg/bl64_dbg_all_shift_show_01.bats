function _test_bl64_dbg_all_shift_show() {
  shift 2
  bl64_dbg_all_shift_show
}

@test "bl64_dbg_all_shift_show: show comments" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run _test_bl64_dbg_all_shift_show A B

  assert_success

}

setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_lib_env: public constants are set" {

  assert_equal "$BL64_LIB_SIGNAL_HUP" "-"
  assert_equal "$BL64_LIB_SIGNAL_STOP" "-"
  assert_equal "$BL64_LIB_SIGNAL_QUIT" "-"
  assert_equal "$BL64_LIB_SIGNAL_DEBUG" "-"
  assert_equal "$BL64_LIB_SIGNAL_EXIT" "bl64_dbg_runtime_show"
  assert_equal "$BL64_LIB_SIGNAL_ERR" "bl64_dbg_callstack_show"

}

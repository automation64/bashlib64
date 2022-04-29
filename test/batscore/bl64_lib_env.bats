setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_lib_env: defaults are set" {
  assert_not_equal "$BL64_LIB_CMD" ''
  assert_not_equal "$BL64_LIB_DEBUG" ''
  assert_not_equal "$BL64_LIB_LANG" ''
  assert_not_equal "$BL64_LIB_SIGNAL_HUP" ''
  assert_not_equal "$BL64_LIB_SIGNAL_QUIT" ''
  assert_not_equal "$BL64_LIB_SIGNAL_STOP" ''
  assert_not_equal "$BL64_LIB_STRICT" ''
  assert_not_equal "$BL64_LIB_VERBOSE" ''
  assert_not_equal "$BL64_SCRIPT_NAME" ''
  assert_not_equal "$BL64_SCRIPT_SID" ''

}

@test "bl64_lib_env: public constants are set" {
  assert_equal "$BL64_LIB_VAR_FALSE" '1'
  assert_equal "$BL64_LIB_VAR_NULL" '__'
  assert_equal "$BL64_LIB_VAR_OFF" '0'
  assert_equal "$BL64_LIB_VAR_OK" '0'
  assert_equal "$BL64_LIB_VAR_ON" '1'
  assert_equal "$BL64_LIB_DEFAULT" '_'
  assert_equal "$BL64_LIB_VAR_TRUE" '0'
}

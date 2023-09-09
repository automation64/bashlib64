setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_lib_env: global flags are set" {
  assert_not_equal "$BL64_LIB_CMD" ''
  assert_not_equal "$BL64_LIB_COMPATIBILITY" ''
  assert_not_equal "$BL64_LIB_LANG" ''
  assert_not_equal "$BL64_LIB_STRICT" ''
  assert_not_equal "$BL64_LIB_TRAPS" ''
}

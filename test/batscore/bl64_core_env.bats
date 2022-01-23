setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_core_env: defaults are set" {
  assert_not_equal "$BL64_LIB_DEBUG" ''
  assert_not_equal "$BL64_LIB_STRICT" ''
  assert_not_equal "$BL64_LIB_LANG" ''
  assert_not_equal "$BL64_LIB_SIGNAL_HUP" ''
  assert_not_equal "$BL64_LIB_SIGNAL_STOP" ''
  assert_not_equal "$BL64_LIB_SIGNAL_QUIT" ''
  assert_not_equal "$BL64_SCRIPT_NAME" ''
  assert_not_equal "$BL64_SCRIPT_SID" ''
}

@test "bl64_core_env: public constants are set" {
  assert_equal "$BL64_LIB_VAR_NULL" '__s64__'
  assert_equal "$BL64_LIB_VAR_TBD" 'TBD'
}

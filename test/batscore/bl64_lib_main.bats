setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_lib_main: lang is set" {
  assert_equal "$LANG" 'C'
  assert_equal "$LC_ALL" 'C'
  assert_equal "$LANGUAGE" 'C'
}

@test "bl64_lib_main: default flags are set" {
  assert_equal "$BL64_LIB_CMD" '0'
  assert_equal "$BL64_LIB_DEBUG" '0'
  assert_equal "$BL64_LIB_STRICT" '1'
  assert_equal "$BL64_LIB_LANG" '1'
  assert_equal "$BL64_LIB_SIGNAL_HUP" '-'
  assert_equal "$BL64_LIB_SIGNAL_STOP" '-'
  assert_equal "$BL64_LIB_SIGNAL_QUIT" '-'
  assert_equal "$BL64_LIB_VAR_NULL" '__'
  assert_equal "$BL64_LIB_DEFAULT" '_'
}

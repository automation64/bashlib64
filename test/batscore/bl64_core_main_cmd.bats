setup() {
  export BL64_LIB_CMD='1'
  . "$DEVBL64_TEST_BASHLIB64" true
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_core_main_cmd: lang is set" {
  assert_equal "$LANG" 'C'
  assert_equal "$LC_ALL" 'C'
  assert_equal "$LANGUAGE" 'C'
}

@test "bl64_core_main_cmd: default flags are set" {
  assert_equal "$BL64_LIB_DEBUG" '0'
  assert_equal "$BL64_LIB_STRICT" '1'
  assert_equal "$BL64_LIB_LANG" '1'
  assert_equal "$BL64_LIB_SIGNAL_HUP" '-'
  assert_equal "$BL64_LIB_SIGNAL_STOP" '-'
  assert_equal "$BL64_LIB_SIGNAL_QUIT" '-'
  assert_equal "$BL64_LIB_VAR_NULL" '__s64__'
  assert_equal "$BL64_LIB_VAR_TBD" 'TBD'
}

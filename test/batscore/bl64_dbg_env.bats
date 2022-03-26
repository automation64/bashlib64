setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_lib_env: debug constants are set" {
  assert_equal "$BL64_DBG_TARGET_NONE" '0'
  assert_equal "$BL64_DBG_TARGET_CMD" '1'
  assert_equal "$BL64_DBG_TARGET_ALL_TRACE" '2'
  assert_equal "$BL64_DBG_TARGET_APP_TRACE" '3'
  assert_equal "$BL64_DBG_TARGET_APP_TASK" '4'
  assert_equal "$BL64_DBG_TARGET_LIB_TRACE" '5'
  assert_equal "$BL64_DBG_TARGET_LIB_TASK" '6'
}

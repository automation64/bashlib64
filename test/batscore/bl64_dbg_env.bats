setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_lib_env: debug constants are set" {
assert_equal "$BL64_DBG_TARGET_NONE" '0'
assert_equal "$BL64_DBG_TARGET_LIB" '1'
assert_equal "$BL64_DBG_TARGET_APP" '2'
assert_equal "$BL64_DBG_TARGET_CMD" '3'
}

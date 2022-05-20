setup() {
  . "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
  . "$TESTMANSH_CMD_BATS_HELPER_FILE"
}

@test "bl64_lib_main_cmd: execute true" {
  export BL64_LIB_CMD='1'
  run bash "$DEVBL_TEST_BASHLIB64" true
  assert_equal "$status" '0'
}

@test "bl64_lib_main_cmd: execute false" {
  export BL64_LIB_CMD='1'
  run bash "$DEVBL_TEST_BASHLIB64" false
  assert_equal "$status" '1'
}

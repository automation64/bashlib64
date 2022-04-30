setup() {
  . "${DEVBL_BATS_HELPER_SUPPORT}/load.bash"
  . "${DEVBL_BATS_HELPER_ASSERT}/load.bash"
  . "${DEVBL_BATS_HELPER_FILE}/load.bash"

}

@test "bl64_lib_main_cmd: execute true" {
  export BL64_LIB_CMD='1'
  run "$DEVBL_TEST_BASHLIB64" true
  assert_equal "$status" '0'
}

@test "bl64_lib_main_cmd: execute false" {
  export BL64_LIB_CMD='1'
  run "$DEVBL_TEST_BASHLIB64" false
  assert_equal "$status" '1'
}

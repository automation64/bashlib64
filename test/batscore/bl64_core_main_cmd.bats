setup() {
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_core_main_cmd: execute true" {
  export BL64_LIB_CMD='1'
  run "$DEVBL64_TEST_BASHLIB64" true
  assert_equal "$status" '0'
}

@test "bl64_core_main_cmd: execute false" {
  export BL64_LIB_CMD='1'
  run "$DEVBL64_TEST_BASHLIB64" false
  assert_equal "$status" '1'
}

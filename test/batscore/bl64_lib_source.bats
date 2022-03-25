setup() {
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_lib_source: load library with defaults" {
  run . "$DEVBL_TEST_BASHLIB64"
  assert_success
}

@test "bl64_lib_source: load library with BL64_LIB_STRICT=1" {
  export BL64_LIB_STRICT='1'
  run . "$DEVBL_TEST_BASHLIB64"
  assert_success
}

@test "bl64_lib_source: load library with BL64_LIB_DEBUG=1" {
  export BL64_LIB_DEBUG='1'
  run . "$DEVBL_TEST_BASHLIB64"
  assert_success
}

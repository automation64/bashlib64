setup() {
  . "${DEVBL_BATS_HELPER_SUPPORT}/load.bash"
  . "${DEVBL_BATS_HELPER_ASSERT}/load.bash"
  . "${DEVBL_BATS_HELPER_FILE}/load.bash"
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

setup() {
  . "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
  . "$TESTMANSH_CMD_BATS_HELPER_FILE"
}

@test "bl64_lib_source: load library with defaults" {
  run . "${TESTMANSH_PROJECT_BUILD}/bashlib64.bash"
  assert_success
}

@test "bl64_lib_source: load library with BL64_LIB_STRICT=1" {
  export BL64_LIB_STRICT='1'
  run . "${TESTMANSH_PROJECT_BUILD}/bashlib64.bash"
  assert_success
}

@test "bl64_lib_source: load library with BL64_LIB_DEBUG=1" {
  export BL64_LIB_DEBUG='1'
  run . "${TESTMANSH_PROJECT_BUILD}/bashlib64.bash"
  assert_success
}

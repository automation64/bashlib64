setup() {
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_core_source: load library with defaults" {
  run . "${DEVBL64_TEST}/lib/bashlib64.bash"
  assert_success
}

@test "bl64_core_source: load library with BL64_LIB_STRICT=1" {
  export BL64_LIB_STRICT='1'
  run . "${DEVBL64_TEST}/lib/bashlib64.bash"
  assert_success
}

@test "bl64_core_source: load library with BL64_LIB_DEBUG=1" {
  export BL64_LIB_DEBUG='1'
  run . "${DEVBL64_TEST}/lib/bashlib64.bash"
  assert_success
}

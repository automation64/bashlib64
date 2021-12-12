@test "bl64_core_source: load library with defaults" {
  run . "${DEVBL64_TEST}/lib/bashlib64.bash"
  [[ "$status" == 0 ]]
}

@test "bl64_core_source: load library with BL64_LIB_STRICT=1" {
  export BL64_LIB_STRICT='1'
  run . "${DEVBL64_TEST}/lib/bashlib64.bash"
  [[ "$status" == 0 ]]
}

@test "bl64_core_source: load library with BL64_LIB_DEBUG=1" {
  export BL64_LIB_DEBUG='1'
  run . "${DEVBL64_TEST}/lib/bashlib64.bash"
  [[ "$status" == 0 ]]
}

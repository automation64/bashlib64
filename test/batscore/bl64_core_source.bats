@test "load library with defaults" {
  run . "${PROJECT_BL64_BUILD}/bashlib64.bash"
  [[ "$status" == 0 ]]
}

@test "load library with BL64_LIB_STRICT=1" {
  export BL64_LIB_STRICT='1'
  run . "${PROJECT_BL64_BUILD}/bashlib64.bash"
  [[ "$status" == 0 ]]
}

@test "load library with BL64_LIB_DEBUG=1" {
  export BL64_LIB_DEBUG='1'
  run . "${PROJECT_BL64_BUILD}/bashlib64.bash"
  [[ "$status" == 0 ]]
}

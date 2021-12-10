@test "load library set" {
  run . "${PROJECT_BL64_BUILD}/bashlib64.bash"
  [[ "$status" == 0 ]]
}

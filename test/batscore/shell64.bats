@test "load library set" {
  run . "${PROJECT_BL64_SRC}/bashlib64.bash"
  [[ "$status" == 0 ]]
}

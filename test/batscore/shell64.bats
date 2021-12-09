@test "load library set" {
  run . "${PROJECT_SHELL64_SRC}/shell64.bash"
  [[ "$status" == 0 ]]
}

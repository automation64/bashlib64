@test "run script with defaults" {
  export X_PATH_TO_LIB_X="${DEVBL64_BUILD}"
  run . "${DEVBL64_SKEL}/generic.bash"
  [[ "$status" == 1 ]]
}

@test "run script with -h" {
  export X_PATH_TO_LIB_X="${DEVBL64_BUILD}"
  run . "${DEVBL64_SKEL}/generic.bash" -h
  [[ "$status" == 0 ]]
}

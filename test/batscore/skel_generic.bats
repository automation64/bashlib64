@test "run script with defaults" {
  export X_PATH_TO_LIB_X="${DEVBL64_TEST}/lib"
  run . "${DEVBL64_TEST}/skel/generic"
  [[ "$status" == 1 ]]
}

@test "run script with -h" {
  export X_PATH_TO_LIB_X="${DEVBL64_TEST}/lib"
  run . "${DEVBL64_TEST}/skel/generic" -h
  [[ "$status" == 0 ]]
}

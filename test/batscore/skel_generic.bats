setup() {
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"
}

@test "skel_generic: run script with defaults" {
  export X_PATH_TO_LIB_X="${DEVBL64_TEST}/lib"
  run . "${DEVBL64_TEST}/skel/generic"
  [[ "$status" == 1 ]]
}

@test "skel_generic: run script with -h" {
  export X_PATH_TO_LIB_X="${DEVBL64_TEST}/lib"
  run . "${DEVBL64_TEST}/skel/generic" -h
  assert_success
}

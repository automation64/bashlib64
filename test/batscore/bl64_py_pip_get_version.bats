setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_py_pip_get_version: get version" {

  set +u # to avoid IFS missing error in run function
  run bl64_py_pip_get_version

  assert_success
  assert_not_equal "$output" ''
}

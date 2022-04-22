setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
}

@test "bl64_dbg_runtime_show: run" {

  set +u # to avoid IFS missing error in run function
  true
  run bl64_dbg_runtime_show

  assert_success

}

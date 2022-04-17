setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_msg_show_unsupported: syntax" {

  set +u # to avoid IFS missing error in run function
  run bl64_msg_show_unsupported 'test'
  assert_success
}

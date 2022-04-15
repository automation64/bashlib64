setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_msg_setup: missing format" {

  run bl64_msg_setup
  assert_failure
  assert_equal "$status" $BL64_MSG_ERROR_INVALID_FORMAT

}

@test "bl64_msg_setup: invalid format" {

  run bl64_msg_setup 'NOT_VALID'
  assert_failure
  assert_equal "$status" $BL64_MSG_ERROR_INVALID_FORMAT

}

@test "bl64_msg_setup: set format" {

  bl64_msg_setup "$BL64_MSG_FORMAT_CALLER"
  assert_success

}

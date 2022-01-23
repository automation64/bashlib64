setup() {
  BL64_LIB_STRICT=0
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_msg_setup: missing format" {

  run bl64_msg_setup
  assert_equal "$status" $BL64_MSG_ERROR_INVALID_FORMAT

}

@test "bl64_msg_setup: invalid format" {

  run bl64_msg_setup 'NOT_VALID'
  assert_equal "$status" $BL64_MSG_ERROR_INVALID_FORMAT

}

@test "bl64_msg_setup: set format" {

  bl64_msg_setup "$BL64_MSG_FORMAT_CALLER"

  assert_equal $? 0
  assert_equal "$BL64_MSG_FORMAT" "$BL64_MSG_FORMAT_CALLER"

}

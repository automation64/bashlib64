setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

}

@test "bl64_msg_env: public constants are set" {

  assert_equal "$BL64_MSG_FORMAT_PLAIN" 'R'
  assert_equal "$BL64_MSG_FORMAT_HOST" 'H'
  assert_equal "$BL64_MSG_FORMAT_TIME" 'T'
  assert_equal "$BL64_MSG_FORMAT_CALLER" 'C'
  assert_equal "$BL64_MSG_FORMAT_FULL" 'F'
  assert_equal "$BL64_MSG_ERROR_INVALID_FORMAT" 200

}

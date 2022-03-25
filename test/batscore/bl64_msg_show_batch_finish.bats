setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  bl64_msg_setup "$BL64_MSG_FORMAT_FULL"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_msg_show_batch_finish: ok" {
  local value='testing batch msg'
  local finish=0

  run bl64_msg_show_batch_finish $finish "$value"

  assert_success
}

@test "bl64_msg_show_batch_finish: error" {
  local value='testing batch msg'
  local finish=10

  run bl64_msg_show_batch_finish $finish "$value"

  assert_success
}

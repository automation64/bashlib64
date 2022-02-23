setup() {
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

  bl64_msg_setup "$BL64_MSG_FORMAT_FULL"
  set +u # to avoid IFS missing error in run function
}

@test "bl64_msg_show_batch_finish: ok" {
  local value='testing batch msg'
  local finish=0

  run bl64_msg_show_batch_finish $finish "$value"

  assert_output --partial "${_BL64_MSG_TXT_BATCH_FINISH_OK}: $value"
}

@test "bl64_msg_show_batch_finish: error" {
  local value='testing batch msg'
  local finish=10

  run bl64_msg_show_batch_finish $finish "$value"

  assert_output --partial "${_BL64_MSG_TXT_BATCH_FINISH_ERROR}: $value (error: ${finish})"
}

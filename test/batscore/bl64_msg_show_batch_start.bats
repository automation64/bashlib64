setup() {
  BL64_LIB_STRICT=0
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

  bl64_msg_setup "$BL64_MSG_FORMAT_FULL"
}

@test "bl64_msg_show_task: output" {
  local value='testing batch msg'

  run bl64_msg_show_batch_start "$value"

  assert_output --partial "${_BL64_MSG_TXT_BATCH_START}: $value"
}

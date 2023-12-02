setup() {
  . "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
  . "$TESTMANSH_CMD_BATS_HELPER_FILE"
}

function _bl64_lib_cmd_01() {
  local -i result=0

  export BL64_LIB_TRAPS='0'
  export BL64_LIB_CMD='1'
  "$DEV_TEST_PATH_LIBRARY/bashlib64.bash" bl64_msg_show_text 'test'
  result=$?
  set -o 'errexit'
  set +o 'nounset'

  return $result
}

@test "bl64_lib_cmd: run one bl64 function" {
  run _bl64_lib_cmd_01
  assert_success
  assert_output 'test'
}

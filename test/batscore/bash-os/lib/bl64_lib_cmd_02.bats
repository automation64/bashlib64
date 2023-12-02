setup() {
  . "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
  . "$TESTMANSH_CMD_BATS_HELPER_FILE"
}

function _bl64_lib_cmd() {
  local -i result=0

  export BL64_LIB_TRAPS='0'
  export BL64_LIB_CMD='1'
  "$DEV_TEST_PATH_LIBRARY/bashlib64.bash" 'env' | grep -E '^BL64_SCRIPT_PATH|^BL64_SCRIPT_NAME|^BL64_SCRIPT_ID|^BL64_SCRIPT_SID'
  result=$?
  set -o 'errexit'
  set +o 'nounset'

  return $result
}

@test "bl64_lib_cmd: identity set" {
  run _bl64_lib_cmd
  assert_success
}

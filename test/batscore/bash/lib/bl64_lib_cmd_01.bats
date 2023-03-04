setup() {
  . "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
  . "$TESTMANSH_CMD_BATS_HELPER_FILE"
}

function _bl64_lib_cmd() {
  local -i result=0

  export BL64_LIB_TRAPS='0'
  export BL64_LIB_CMD='1'
  "${TESTMANSH_PROJECT_BUILD}/bashlib64.bash" "$1"
  result=$?
  set -o 'errexit'
  set +o 'nounset'

  return $result
}

@test "bl64_lib_cmd: execute false" {
  run _bl64_lib_cmd 'false'
  assert_failure
}

@test "bl64_lib_cmd: execute true" {
  run _bl64_lib_cmd 'true'
  assert_success
}

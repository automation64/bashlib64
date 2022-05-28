setup() {
  . "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
  . "$TESTMANSH_CMD_BATS_HELPER_FILE"
}

@test "bl64_lib_cmd: execute true" {
  export BL64_LIB_TRAPS='0'
  export BL64_LIB_CMD='1'
  run "${TESTMANSH_PROJECT_BUILD}/bashlib64.bash" 'true'
  set -o 'errexit'
  set +o 'nounset'
  assert_success
}

@test "bl64_lib_cmd: execute false" {
  export BL64_LIB_TRAPS='0'
  export BL64_LIB_CMD='1'
  run "${TESTMANSH_PROJECT_BUILD}/bashlib64.bash" 'false'
  set -o 'errexit'
  set +o 'nounset'
  assert_failure
}

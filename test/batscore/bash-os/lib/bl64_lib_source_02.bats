setup() {
  . "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
  . "$TESTMANSH_CMD_BATS_HELPER_FILE"
}

@test "bl64_lib_source: script vars are set" {

  BL64_LIB_TRAPS='0'
  . "$DEV_TEST_PATH_LIBRARY/bashlib64.bash"
  set -o 'errexit'
  set +o 'nounset'

  assert_not_equal "$BL64_SCRIPT_SID" ''
}

setup() {
  . "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
  . "$TESTMANSH_CMD_BATS_HELPER_FILE"
}

@test "bl64_lib_source: script vars are set" {

  export _DEV_LIB_BASHLIB64_BUILD="$DEV_TEST_PATH_LIBRARY/bashlib64.bash"
  run "${TESTMANSH_TEST_SAMPLES}/script_01/template" -n
  assert_success
  assert_output 'template'

}

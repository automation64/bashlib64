setup() {
  . "$TESTMANSH_CMD_BATS_HELPER_SUPPORT"
  . "$TESTMANSH_CMD_BATS_HELPER_ASSERT"
  . "$TESTMANSH_CMD_BATS_HELPER_FILE"
}

@test "bl64_lib_source: script vars are set" {

  export _DEV_LIB_BASHLIB64_BUILD="${TESTMANSH_PROJECT_BUILD}/bashlib64.bash"
  run "${TESTMANSH_TEST_SAMPLES}/script_01/template" -t
  assert_success
  assert_output 'sample_script_test'

}

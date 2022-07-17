setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x "$BL64_TXT_CMD_ENVSUBST" ]] || skip
}

function _test_bl64_txt_replace_env() {

  export _SAMPLES_ENVSUBST_01='hello world'
  bl64_txt_replace_env "$TESTMANSH_TEST_SAMPLES/envsubst_01/simple.txt"

}

@test "bl64_txt_replace_env: run ok" {
  expected='# Test file for replacing shell variables

Simple replacement: hello world'

  run _test_bl64_txt_replace_env
  assert_success
  assert_output "$expected"

}

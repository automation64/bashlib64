setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  [[ -x "$BL64_TXT_CMD_ENVSUBST" ]] || skip 'envsubst not found'
}

function _test_bl64_txt_run_envsubst() {

  export replace_this_var='hello world'
  echo 'example text with shell variable: [${replace_this_var}]' | bl64_txt_run_envsubst

}

@test "bl64_txt_run_envsubst: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  expected='example text with shell variable: [hello world]'

  run _test_bl64_txt_run_envsubst
  assert_success
  assert_output "$expected"

}

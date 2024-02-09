function _test_bl64_txt_run_grep() {

  input='hello world'
  echo "$input" | bl64_txt_run_grep 'world'

}

@test "bl64_txt_run_grep: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  expected='hello world'

  run _test_bl64_txt_run_grep
  assert_success
  assert_output "$expected"

}

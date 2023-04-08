setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_txt_run_tr() {

  input='hello world'
  echo "$input" | bl64_txt_run_tr 'o' 'x'

}

@test "bl64_txt_run_tr: run ok" {
  expected='hellx wxrld'

  run _test_bl64_txt_run_tr
  assert_success
  assert_output "$expected"

}

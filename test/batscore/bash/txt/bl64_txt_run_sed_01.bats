setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_txt_run_sed() {

  input='hello world'
  echo "$input" | bl64_txt_run_sed 's/l//g'

}

@test "bl64_txt_run_sed: run ok" {
  expected='heo word'

  run _test_bl64_txt_run_sed
  assert_success
  assert_output "$expected"

}

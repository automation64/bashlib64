setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_txt_run_base64() {

  input='hello world'
  echo "$input" | bl64_txt_run_base64

}

@test "bl64_txt_run_base64: run ok" {
  expected='aGVsbG8gd29ybGQK'

  run _test_bl64_txt_run_base64
  assert_success
  assert_output "$expected"

}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_txt_run_egrep() {

  input='hello World'
  echo "$input" | bl64_txt_run_egrep '[Ww]orld'

}

@test "bl64_txt_run_egrep: run ok" {
  expected='hello World'

  run _test_bl64_txt_run_egrep
  assert_success
  assert_output "$expected"

}

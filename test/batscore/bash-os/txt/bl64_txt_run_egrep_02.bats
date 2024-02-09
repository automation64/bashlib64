function _test_bl64_txt_run_egrep() {

  input='hello World'
  echo "$input" | bl64_txt_run_egrep '[Ww]orld'

}

@test "bl64_txt_run_egrep: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  expected='hello World'

  run _test_bl64_txt_run_egrep
  assert_success
  assert_output "$expected"

}

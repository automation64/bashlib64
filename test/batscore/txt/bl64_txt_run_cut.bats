setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_txt_run_cut() {

  input='hello world'
  echo "$input" | bl64_txt_run_cut -d' ' -f2

}

@test "bl64_txt_run_cut: run ok" {
  expected='world'

  run _test_bl64_txt_run_cut
  assert_success
  assert_output "$expected"

}

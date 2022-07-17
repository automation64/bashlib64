setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

function _test_bl64_txt_replace_env() {

  bl64_txt_replace_env "$1"

}

@test "bl64_txt_replace_env: no args" {

  run _test_bl64_txt_replace_env
  assert_failure

}

@test "bl64_txt_replace_env: wrong file" {

  run _test_bl64_txt_replace_env '/no/file'
  assert_failure

}

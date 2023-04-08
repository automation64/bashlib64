setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_txt_replace_env: parameters are not present" {
  run bl64_txt_replace_env
  assert_failure
}

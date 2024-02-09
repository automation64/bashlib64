@test "bl64_txt_replace_env: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_replace_env
  assert_failure
}

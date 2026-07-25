@test "bl64_txt_modify: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_modify
  assert_failure
}

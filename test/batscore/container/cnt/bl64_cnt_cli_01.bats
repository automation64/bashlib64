@test "bl64_cnt_cli: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_cnt_cli
  assert_failure
}
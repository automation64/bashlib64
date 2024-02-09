@test "bl64_txt_run_uniq: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_uniq
  assert_failure
}

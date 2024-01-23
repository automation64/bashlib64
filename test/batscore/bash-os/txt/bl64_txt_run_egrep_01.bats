@test "bl64_txt_run_egrep: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_run_egrep
  assert_failure
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_txt_run_egrep: parameters are not present" {
  run bl64_txt_run_egrep
  assert_failure
}

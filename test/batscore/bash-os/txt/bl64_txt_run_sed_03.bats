setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_txt_run_sed: parameters are not present" {
  run bl64_txt_run_sed
  assert_failure
}

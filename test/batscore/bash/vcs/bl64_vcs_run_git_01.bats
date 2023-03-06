setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_vcs_run_git: parameters are not present" {
  run bl64_vcs_run_git
  assert_failure
}
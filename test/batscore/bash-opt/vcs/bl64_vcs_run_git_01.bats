@test "bl64_vcs_run_git: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_run_git
  assert_failure
}
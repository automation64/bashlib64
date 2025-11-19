@test "bl64_vcs_github_run_api: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_github_run_api
  assert_failure
}

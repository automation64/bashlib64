@test "bl64_vcs_github_run_api: call API ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_github_run_api '/rate_limit'
  assert_success
}

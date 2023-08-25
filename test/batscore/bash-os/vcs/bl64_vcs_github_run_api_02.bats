setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_vcs_github_run_api: call API ok" {
  run bl64_vcs_github_run_api '/octocat'
  assert_success
}

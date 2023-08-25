setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_vcs_github_run_api: parameters are not present" {
  run bl64_vcs_github_run_api
  assert_failure
}

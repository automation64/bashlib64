@test "bl64_vcs_github_release_get_latest: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_github_release_get_latest
  assert_failure
}
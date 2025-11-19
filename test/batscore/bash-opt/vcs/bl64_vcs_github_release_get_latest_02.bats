@test "bl64_vcs_github_release_get_latest: wrong user" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_github_release_get_latest 'nonexistingrepo' "$DEV_TEST_VALUE_GIT_RELEASE_REPO"
  assert_failure
}

@test "bl64_vcs_github_release_get_latest: wrong repo name" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_github_release_get_latest "$DEV_TEST_VALUE_GIT_RELEASE_OWNER" 'notareponame'
  assert_failure
}

@test "bl64_vcs_github_release_get_latest: get release ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  export release="$(bl64_vcs_github_release_get_latest "$DEV_TEST_VALUE_GIT_RELEASE_OWNER" "$DEV_TEST_VALUE_GIT_RELEASE_REPO")"
  assert_not_equal "$release" ''
}

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

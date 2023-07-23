setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_vcs_github_release_get_latest: get release" {
  export release="$(bl64_vcs_github_release_get_latest "$DEVBL_TEST_VALUE_GIT_OWNER" "$DEVBL_TEST_VALUE_GIT_REPO")"
  assert_not_equal "$release" ''
}

@test "bl64_vcs_github_release_get_latest: wrong user" {
  run bl64_vcs_github_release_get_latest 'nonexistingrepo' "$DEVBL_TEST_VALUE_GIT_REPO"
  assert_failure
  assert_output ''
}

@test "bl64_vcs_github_release_get_latest: wrong repo name" {
  run bl64_vcs_github_release_get_latest "$DEVBL_TEST_VALUE_GIT_OWNER" 'notareponame'
  assert_failure
  assert_output ''
}

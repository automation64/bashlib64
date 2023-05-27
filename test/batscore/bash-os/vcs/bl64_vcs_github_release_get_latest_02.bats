setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_vcs_github_release_get_latest: get release" {
  export release="$(bl64_vcs_github_release_get_latest 'serdigital64' 'helm64')"
  assert_not_equal "$release" ''
}

@test "bl64_vcs_github_release_get_latest: wrong user" {
  run bl64_vcs_github_release_get_latest 'nonexistingrepo' 'helm64'
  assert_failure
  assert_output ''
}

@test "bl64_vcs_github_release_get_latest: wrong repo name" {
  run bl64_vcs_github_release_get_latest 'serdigital64' 'notareponame'
  assert_failure
  assert_output ''
}

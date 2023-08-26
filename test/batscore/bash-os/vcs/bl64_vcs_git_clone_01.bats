setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  _bl64_vcs_git_clone_destination="$(mktemp -d)"
  export _bl64_vcs_git_clone_destination
}

teardown() {

  [[ -d "$_bl64_vcs_git_clone_destination" ]] && rm -Rf "$_bl64_vcs_git_clone_destination"

}

@test "bl64_vcs_git_clone: parameter 1 is not present" {

  run bl64_vcs_git_clone
  assert_failure

}

@test "bl64_vcs_git_clone: parameter 2 is not present" {

  run bl64_vcs_git_clone 'source'
  assert_failure

}

@test "bl64_vcs_git_clone: clone repo" {

  run bl64_vcs_git_clone "$DEVBL_TEST_VALUE_GIT_CLONE_URL" "$_bl64_vcs_git_clone_destination" 'main'
  assert_success

}

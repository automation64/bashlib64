setup() {
  _bl64_vcs_git_sparse_destination="$(mktemp -d)"
  export _bl64_vcs_git_sparse_destination
}

teardown() {

  [[ -d "$_bl64_vcs_git_sparse_destination" ]] && rm -Rf "$_bl64_vcs_git_sparse_destination"

}

@test "bl64_vcs_git_sparse: parameter 1 is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_vcs_git_sparse
  assert_failure

}

@test "bl64_vcs_git_sparse: parameter 2 is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_vcs_git_sparse 'source'
  assert_failure

}

@test "bl64_vcs_git_sparse: parameter 4 is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_vcs_git_sparse 'source' "$_bl64_vcs_git_sparse_destination" 'main'
  assert_failure

}

@test "bl64_vcs_git_sparse: sparse checkout" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_vcs_git_sparse "$DEV_TEST_VALUE_GIT_CLONE_URL" "$_bl64_vcs_git_sparse_destination" 'main' 'bin/ build/'
  assert_success
}

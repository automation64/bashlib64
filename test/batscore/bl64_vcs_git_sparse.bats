setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  _bl64_vcs_git_sparse_destination="$(mktemp -d)"
  export _bl64_vcs_git_sparse_destination
  set +u # to avoid IFS missing error in run function
}

teardown() {

  [[ -d "$_bl64_vcs_git_sparse_destination" ]] && rm -Rf "$_bl64_vcs_git_sparse_destination"

}

@test "bl64_vcs_git_sparse: parameter 1 is not present" {

  run bl64_vcs_git_sparse
  assert_equal "$status" $BL64_VCS_ERROR_MISSING_PARAMETER

}

@test "bl64_vcs_git_sparse: parameter 2 is not present" {

  run bl64_vcs_git_sparse 'source'
  assert_equal "$status" $BL64_VCS_ERROR_MISSING_PARAMETER

}

@test "bl64_vcs_git_sparse: parameter 4 is not present" {

  run bl64_vcs_git_sparse 'source' "$_bl64_vcs_git_sparse_destination" 'main'
  assert_equal "$status" $BL64_VCS_ERROR_MISSING_PARAMETER

}

@test "bl64_vcs_git_sparse: sparse checkout" {
  run bl64_vcs_git_sparse 'https://github.com/serdigital64/bashlib64.git' "$_bl64_vcs_git_sparse_destination" 'main' 'bin/ build/'
  assert_success

}

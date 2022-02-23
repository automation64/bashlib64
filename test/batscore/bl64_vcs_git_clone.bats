setup() {
  BL64_LIB_STRICT=0
  . "$DEVBL64_TEST_BASHLIB64"
  . "${DEVBL64_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL64_BATS_HELPER}/bats-file/load.bash"

  _bl64_vcs_git_clone_destination="$(mktemp -d)"
  export _bl64_vcs_git_clone_destination

}

teardown() {

  [[ -d "$_bl64_vcs_git_clone_destination" ]] && rm -Rf "$_bl64_vcs_git_clone_destination"

}

@test "bl64_vcs_git_clone: parameter 1 is not present" {

  run bl64_vcs_git_clone
  assert_equal "$status" $BL64_VCS_ERROR_MISSING_PARAMETER

}

@test "bl64_vcs_git_clone: parameter 2 is not present" {

  run bl64_vcs_git_clone 'source'
  assert_equal "$status" $BL64_VCS_ERROR_MISSING_PARAMETER

}

@test "bl64_vcs_git_clone: clone repo" {

  run bl64_vcs_git_clone 'https://github.com/serdigital64/bashlib64.git' "$_bl64_vcs_git_clone_destination" 'main'
  assert_success

}

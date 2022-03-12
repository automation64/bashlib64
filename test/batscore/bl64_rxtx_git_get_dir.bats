setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  _bl64_rxtx_git_get_dir_destination="$(mktemp -d)"
  export _bl64_rxtx_git_get_dir_destination
  set +u # to avoid IFS missing error in run function
}

teardown() {

  [[ -d "$_bl64_rxtx_git_get_dir_destination" ]] && rm -Rf "$_bl64_rxtx_git_get_dir_destination"

}

@test "bl64_rxtx_git_get_dir: git dir" {

  run bl64_rxtx_git_get_dir 'https://github.com/serdigital64/bashlib64.git' "$_bl64_rxtx_git_get_dir_destination" 'main' 'bin/ build/'
  assert_success

}

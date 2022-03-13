setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  _bl64_rxtx_git_get_dir_destination="$(mktemp -d)"
  _bl64_rxtx_git_get_dir_source='https://github.com/serdigital64/bashlib64.git'
  export _bl64_rxtx_git_get_dir_destination
  export _bl64_rxtx_git_get_dir_source
  set +u # to avoid IFS missing error in run function
}

teardown() {

  [[ -d "$_bl64_rxtx_git_get_dir_destination" ]] && rm -Rf "$_bl64_rxtx_git_get_dir_destination"

}

@test "bl64_rxtx_git_get_dir: git dir + replace on" {

  test_dir="${_bl64_rxtx_git_get_dir_destination}/target"
  mkdir -p "$test_dir"

  run bl64_rxtx_git_get_dir \
    "$_bl64_rxtx_git_get_dir_source" \
    'bin' \
    "$test_dir" \
    "$BL64_LIB_VAR_ON"
  assert_success

  assert_dir_exists "${test_dir}"

}

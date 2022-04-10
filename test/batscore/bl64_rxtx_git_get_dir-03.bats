setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"
  _bl64_rxtx_git_get_dir_destination="$(temp_make)"
  _bl64_rxtx_git_get_dir_source='https://github.com/serdigital64/bashlib64.git'
  export _bl64_rxtx_git_get_dir_destination
  export _bl64_rxtx_git_get_dir_source
  set +u # to avoid IFS missing error in run function

}

teardown() {
  temp_del "$_bl64_rxtx_git_get_dir_destination"
}

@test "bl64_rxtx_git_get_dir: git dir ." {

  run bl64_rxtx_git_get_dir \
    "$_bl64_rxtx_git_get_dir_source" \
    '.' \
    "${_bl64_rxtx_git_get_dir_destination}" \
    "$BL64_LIB_VAR_ON"
  assert_success

  assert_dir_exists "${_bl64_rxtx_git_get_dir_destination}/src"

}

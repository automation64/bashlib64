setup() {
  . "$DEVBL_TEST_SETUP"

  _bl64_rxtx_git_get_dir_destination="$(temp_make)"
  _bl64_rxtx_git_get_dir_source='https://github.com/serdigital64/bashlib64.git'
  export _bl64_rxtx_git_get_dir_destination
  export _bl64_rxtx_git_get_dir_source
  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1
}

teardown() {

  temp_del "$_bl64_rxtx_git_get_dir_destination"

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

  assert_file_exists "${test_dir}/target/devbl-set"

}

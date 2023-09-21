setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  _bl64_rxtx_git_get_dir_destination="$(temp_make)"
  _bl64_rxtx_git_get_dir_source="$DEV_TEST_VALUE_GIT_CLONE_URL"
  export _bl64_rxtx_git_get_dir_destination
  export _bl64_rxtx_git_get_dir_source
}

teardown() {
  temp_del "$_bl64_rxtx_git_get_dir_destination"
}

@test "bl64_rxtx_git_get_dir: git dir + replace off" {

  test_dir="${_bl64_rxtx_git_get_dir_destination}/target"

  run bl64_rxtx_git_get_dir \
    "$_bl64_rxtx_git_get_dir_source" \
    'bin' \
    "$test_dir"
  assert_success

  assert_file_exists "${test_dir}/dev-set"

}

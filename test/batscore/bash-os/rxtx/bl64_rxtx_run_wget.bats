setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  _bl64_rxtx_git_get_dir_destination="$(temp_make)"
  _bl64_rxtx_git_get_dir_source='https://github.com/serdigital64/bashlib64.git'
  export _bl64_rxtx_git_get_dir_destination
  export _bl64_rxtx_git_get_dir_source

}

@test "bl64_rxtx_run_wget: parameters are not present" {
  run bl64_rxtx_run_wget
  assert_failure
}

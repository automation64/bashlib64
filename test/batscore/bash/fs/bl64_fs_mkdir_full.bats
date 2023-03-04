setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_TARGET="${TEST_SANDBOX}/test-dir"
}

@test "bl64_fs_mkdir_full: create dir" {
  run bl64_fs_mkdir_full "$TEST_TARGET"
  assert_equal "$status" '0'
  assert_dir_exist "$TEST_TARGET"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

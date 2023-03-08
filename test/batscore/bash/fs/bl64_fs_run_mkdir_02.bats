setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_run_mkdir: create dir level" {
  TEST_TARGET="${TEST_SANDBOX}/test-dir"
  run bl64_fs_run_mkdir "$TEST_TARGET"
  assert_success
  assert_dir_exist "$TEST_TARGET"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
}

@test "bl64_fs_run_mkdir: create dir level" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  TEST_TARGET="${TEST_SANDBOX}/test-dir"
  run bl64_fs_run_mkdir "$TEST_TARGET"
  assert_success
  assert_dir_exist "$TEST_TARGET"
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

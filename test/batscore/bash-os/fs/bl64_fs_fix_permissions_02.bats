setup() {
  DEV_TEST_INIT_ONLY='YES'
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  unset DEV_TEST_INIT_ONLY
  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_TARGET="${TEST_SANDBOX}/test-dir"
}

@test "bl64_fs_fix_permissions: fix all" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_fs_run_mkdir "$TEST_TARGET"
  echo test > "${TEST_TARGET}/file1"
  echo test > "${TEST_TARGET}/file2"
  run bl64_fs_fix_permissions '0600' '0700' "$TEST_TARGET"
  assert_success
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  BATSLIB_TEMP_PRESERVE=0
  BATSLIB_TEMP_PRESERVE_ON_FAILURE=1

  TEST_SANDBOX="$(temp_make)"
  TEST_TARGET="${TEST_SANDBOX}/test-dir"
  bl64_fs_run_mkdir "$TEST_TARGET"
  echo test > "${TEST_TARGET}/file1"
  echo test > "${TEST_TARGET}/file2"

}

@test "bl64_fs_fix_permissions: fix all" {
  run bl64_fs_fix_permissions '0700' '0600' "$TEST_TARGET"
  assert_equal "$status" '0'
}

teardown() {
  temp_del "$TEST_SANDBOX"
}

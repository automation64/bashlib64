@test "bl64_fs_mkdir_full: missing parameter: all" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_mkdir_full
  assert_failure
}
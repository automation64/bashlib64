@test "bl64_fs_dir_reset: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_dir_reset
  assert_failure
}

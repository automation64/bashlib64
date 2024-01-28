@test "bl64_fs_run_chmod: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_chmod
  assert_failure
}

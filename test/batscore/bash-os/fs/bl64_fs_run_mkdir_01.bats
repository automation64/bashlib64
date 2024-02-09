@test "bl64_fs_run_mkdir: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_mkdir
  assert_failure
}

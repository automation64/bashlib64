@test "bl64_fs_run_cp: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_cp
  assert_failure
}

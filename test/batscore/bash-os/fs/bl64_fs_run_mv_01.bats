@test "bl64_fs_run_mv: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_mv
  assert_failure
}

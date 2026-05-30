@test "bl64_fs_run_stat: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_stat
  assert_failure
}

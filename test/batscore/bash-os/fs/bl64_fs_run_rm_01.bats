@test "bl64_fs_run_rm: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_rm
  assert_failure
}

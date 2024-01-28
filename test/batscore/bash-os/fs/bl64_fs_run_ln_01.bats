@test "bl64_fs_run_ln: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_ln
  assert_failure
}

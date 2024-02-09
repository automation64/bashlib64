@test "bl64_fs_run_ls: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_ls
  assert_failure
}

@test "bl64_fs_run_rm: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_touch
  assert_failure
}

@test "bl64_fs_run_rm: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_touch /tmp/1
  assert_success
}

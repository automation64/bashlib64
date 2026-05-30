@test "bl64_fs_run_stat: check file" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_run_stat /dev/null
  assert_success
}

@test "bl64_fs_check_new_dir: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_check_new_dir
  assert_failure
}

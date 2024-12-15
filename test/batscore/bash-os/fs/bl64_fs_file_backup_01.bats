@test "bl64_fs_file_backup: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_backup
  assert_failure
}

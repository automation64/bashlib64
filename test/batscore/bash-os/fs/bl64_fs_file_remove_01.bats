@test "bl64_fs_file_remove: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_file_remove
  assert_success
}

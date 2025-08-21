@test "bl64_fs_rm_file: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_rm_file
  assert_success
}

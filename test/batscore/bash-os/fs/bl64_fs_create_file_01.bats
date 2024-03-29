@test "bl64_fs_create_file: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_create_file
  assert_failure
}

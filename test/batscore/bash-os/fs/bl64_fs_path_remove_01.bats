@test "bl64_fs_path_remove: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_path_remove
  assert_failure
}

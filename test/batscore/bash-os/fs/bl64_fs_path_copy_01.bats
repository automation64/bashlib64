@test "bl64_fs_path_copy: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_path_copy
  assert_failure
}

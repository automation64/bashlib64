@test "bl64_fs_path_permission_set: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_path_permission_set
  assert_failure
}

@test "bl64_fs_symlink_create: missing parameter: all" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_symlink_create
  assert_failure
}

@test "bl64_fs_symlink_create: missing parameter: 2nd" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_symlink_create '/fake/file'
  assert_failure
}

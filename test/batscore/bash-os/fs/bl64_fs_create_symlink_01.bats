@test "bl64_fs_create_symlink: missing parameter: all" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_create_symlink
  assert_failure
}

@test "bl64_fs_create_symlink: missing parameter: 2nd" {
  run bl64_fs_create_symlink '/fake/file'
  assert_failure
}

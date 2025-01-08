@test "bl64_fs_create_symlink: missing source" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_create_symlink \
    "/fake/file" \
    "/not/needed"
  assert_failure
}

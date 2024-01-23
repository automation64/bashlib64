@test "bl64_fs_chown_dir: missing parameter: all" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_chown_dir
  assert_failure
}

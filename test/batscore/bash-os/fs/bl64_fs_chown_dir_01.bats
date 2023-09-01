setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_chown_dir: missing parameter: all" {
  run bl64_fs_chown_dir
  assert_failure
}

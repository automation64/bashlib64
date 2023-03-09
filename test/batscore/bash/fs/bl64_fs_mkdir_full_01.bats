setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_mkdir_full: missing parameter: all" {
  run bl64_fs_mkdir_full
  assert_failure
}
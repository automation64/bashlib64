@test "bl64_fs_cp_file: missing parameter: all" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_cp_file
  assert_failure
}

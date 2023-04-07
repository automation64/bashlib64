setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_cp_file: missing parameter: all" {
  run bl64_fs_cp_file
  assert_failure
}

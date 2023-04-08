setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_rm_file: parameters are not present" {
  run bl64_fs_rm_file
  assert_failure
}

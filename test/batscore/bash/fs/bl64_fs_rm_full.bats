setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_rm_full: parameters are not present" {
  run bl64_fs_rm_full
  assert_failure
}

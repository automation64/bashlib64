@test "bl64_fs_rm_full: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_rm_full
  assert_failure
}

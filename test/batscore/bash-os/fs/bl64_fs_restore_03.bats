@test "bl64_fs_restore: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_restore
  assert_failure
}

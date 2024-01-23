@test "bl64_fs_rm_tmpfile_01: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_rm_tmpfile
  assert_failure
}

@test "bl64_fs_safeguard: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_safeguard
  assert_failure
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_safeguard: parameters are not present" {
  run bl64_fs_safeguard
  assert_failure
}

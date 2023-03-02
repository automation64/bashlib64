setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_run_ln: parameters are not present" {
  run bl64_fs_run_ln
  assert_failure
}

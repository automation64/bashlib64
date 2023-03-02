setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_run_mv: parameters are not present" {
  run bl64_fs_run_mv
  assert_failure
}

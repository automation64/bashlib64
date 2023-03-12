setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_run_rm: parameters are not present" {
  run bl64_fs_run_rm
  assert_failure
}

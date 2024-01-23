@test "bl64_fs_ln_symbolic: missing parameter: all" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fs_ln_symbolic
  assert_failure
}

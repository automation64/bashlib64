setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fs_ln_symbolic: missing parameter: all" {
  run bl64_fs_ln_symbolic
  assert_failure
}

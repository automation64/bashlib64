@test "bl64_lib_harden_options: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_lib_harden_options
  assert_success
}

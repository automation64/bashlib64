@test "bl64_lib_harden_shopt: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_lib_harden_shopt
  assert_success
}

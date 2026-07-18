@test "_bl64_lib_harden_shopt: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run _bl64_lib_harden_shopt
  assert_success
}

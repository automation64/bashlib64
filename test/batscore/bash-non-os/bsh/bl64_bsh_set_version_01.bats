@test "_bl64_bsh_set_version: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_bsh_set_version
  assert_success
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "_bl64_bsh_set_version: run function" {
  run _bl64_bsh_set_version
  assert_success
}

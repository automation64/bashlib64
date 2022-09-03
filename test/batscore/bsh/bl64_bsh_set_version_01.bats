setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_bsh_set_version: run function" {
  run bl64_bsh_set_version
  assert_success
}

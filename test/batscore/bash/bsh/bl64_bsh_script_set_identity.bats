setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_bsh_script_set_identity: result" {
  run bl64_bsh_script_set_identity
  assert_success
}

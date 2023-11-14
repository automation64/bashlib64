setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_lib_script_set_identity: result" {
  run bl64_lib_script_set_identity
  assert_success
}

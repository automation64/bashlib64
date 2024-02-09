@test "bl64_lib_script_set_identity: result" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_lib_script_set_identity
  assert_success
}

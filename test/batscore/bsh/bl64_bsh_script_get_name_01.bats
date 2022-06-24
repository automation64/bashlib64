setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_bsh_script_get_name: current script" {
  run bl64_bsh_script_get_name
  assert_success
}

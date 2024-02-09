@test "bl64_bsh_script_get_name: current script" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_script_get_name
  assert_success
}

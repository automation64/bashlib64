@test "bl64_bsh_script_get_path: current script" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_script_get_path
  assert_success
}

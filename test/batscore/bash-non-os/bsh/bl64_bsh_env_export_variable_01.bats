@test "bl64_bsh_env_export_variable: no arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_env_export_variable
  assert_failure
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_bsh_env_export_variable: no arg" {
  run bl64_bsh_env_export_variable
  assert_failure
}

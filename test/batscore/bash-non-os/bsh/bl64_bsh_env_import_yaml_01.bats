@test "bl64_bsh_env_import_yaml: no arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_env_import_yaml
  assert_failure
}

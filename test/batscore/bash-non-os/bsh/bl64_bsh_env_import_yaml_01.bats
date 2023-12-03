setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_bsh_env_import_yaml: no arg" {
  run bl64_bsh_env_import_yaml
  assert_failure
}

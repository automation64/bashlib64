@test "bl64_bsh_env_export_variable: export ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_env_export_variable 'test_var' 'test_value'
  assert_success
  assert_output "export test_var='test_value'"
}

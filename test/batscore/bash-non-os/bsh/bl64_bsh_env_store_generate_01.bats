@test "bl64_bsh_env_store_generate: generate" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_env_store_generate
  assert_success
}

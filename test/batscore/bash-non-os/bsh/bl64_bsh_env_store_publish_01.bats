@test "bl64_bsh_env_store_publish: missing args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_env_store_publish
  assert_failure
}

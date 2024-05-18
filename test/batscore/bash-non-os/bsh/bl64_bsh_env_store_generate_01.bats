@test "bl64_bsh_env_store_create: create" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_bsh_env_store_create
  assert_success
}

@test "bl64_bsh_env_store_generate: generate" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  run bl64_bsh_env_store_generate
  assert_success
}

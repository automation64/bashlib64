@test "bl64_bsh_env_store_publish: publish ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_cnt_is_inside_container || skip 'test-case for container mode'
  touch /tmp/test_env
  bl64_bsh_env_store_create
  run bl64_bsh_env_store_publish /tmp/test_env
  assert_success
}

@test "bl64_os_set_alias: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_rxtx_set_alias
  assert_success
}

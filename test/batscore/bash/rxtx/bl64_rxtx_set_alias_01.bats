setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_os_set_alias: run function" {
  run _bl64_rxtx_set_alias
  assert_success
}

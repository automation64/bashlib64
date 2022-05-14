setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_rxtx_set_command: run function" {
  run bl64_rxtx_set_command
  assert_success
}

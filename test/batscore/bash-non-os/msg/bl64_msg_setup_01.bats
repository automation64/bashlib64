setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_msg_setup: module setup" {
  run bl64_msg_setup
  assert_success
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_os_setup: module setup" {
  run bl64_os_setup
  assert_success
}

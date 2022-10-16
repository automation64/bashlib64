setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_ui_setup: module setup" {
  run bl64_ui_setup
  assert_success
}

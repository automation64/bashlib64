@test "bl64_ui_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ui_setup
  assert_success
}

@test "bl64_ui_get_command_pager: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_ui_setup
  run bl64_ui_get_command_pager
  assert_success
}

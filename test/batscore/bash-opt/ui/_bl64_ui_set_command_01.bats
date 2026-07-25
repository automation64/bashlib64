@test "_bl64_ui_set_command: commands are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_ui_setup
  assert_not_equal "${BL64_UI_PAGER}" ''
  assert_not_equal "${BL64_UI_TUI}" ''
}

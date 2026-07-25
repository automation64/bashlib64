@test "_bl64_rxtx_set_command: commands are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  assert_not_equal "${BL64_UI_PAGER}" ''
  assert_not_equal "${BL64_UI_TUI}" ''
}

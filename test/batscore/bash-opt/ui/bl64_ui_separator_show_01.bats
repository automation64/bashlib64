@test "bl64_ui_separator_show: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_ui_separator_show "test_text"
  assert_success
}


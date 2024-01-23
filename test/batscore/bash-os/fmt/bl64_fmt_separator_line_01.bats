@test "bl64_fmt_separator_line: run ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_separator_line "test_text"
  assert_success
}


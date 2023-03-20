setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fmt_separator_line: run ok" {
  run bl64_fmt_separator_line "test_text"
  assert_success
}


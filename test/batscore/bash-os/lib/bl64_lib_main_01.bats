@test "bl64_lib_main: locale vars are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  assert_not_equal "$LANG" ''
  assert_not_equal "$LC_ALL" ''
  assert_not_equal "$LANGUAGE" ''
}

@test "bl64_lib_main: tty output var is set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  assert_not_equal "$TERM" ''
}

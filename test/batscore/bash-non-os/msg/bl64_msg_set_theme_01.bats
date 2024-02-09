@test "bl64_msg_set_theme: no args" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_theme
  assert_failure

}

@test "bl64_msg_set_theme: invalid arg" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_theme 'NOT_VALID'
  assert_failure

}

@test "bl64_msg_set_theme: set ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_msg_set_theme 'ansi-std'
  assert_success

}

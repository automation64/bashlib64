setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_msg_set_theme: no args" {

  run bl64_msg_set_theme
  assert_failure

}

@test "bl64_msg_set_theme: invalid arg" {

  run bl64_msg_set_theme 'NOT_VALID'
  assert_failure

}

@test "bl64_msg_set_theme: set ok" {

  run bl64_msg_set_theme 'ansi-std'
  assert_success

}

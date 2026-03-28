@test "bl64_msg_show_setup: non existing vars" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing info msg'

  run bl64_msg_show_setup "$value" 'NOT_EXISTING' 'NOT_EXISTING2'
  assert_success
}

@test "bl64_msg_show_setup: wrong var format" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing info msg'

  run bl64_msg_show_setup "$value" 'wrong var name'
  assert_success
}

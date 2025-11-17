@test "bl64_msg_show_setup: existing vars" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing info msg'

  run bl64_msg_show_setup "$value" 'BL64_VAR_DEFAULT'
  assert_success
}

@test "bl64_msg_show_setup: mixed vars" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing info msg'

  run bl64_msg_show_setup "$value" 'BL64_VAR_DEFAULT' 'NOT_EXISTING'
  assert_success
}

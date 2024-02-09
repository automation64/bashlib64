@test "bl64_msg_show_batch_finish: ok" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing batch msg'
  local finish=0

  run bl64_msg_show_batch_finish $finish "$value"

  assert_success
}

@test "bl64_msg_show_batch_finish: error" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  local value='testing batch msg'
  local finish=10

  run bl64_msg_show_batch_finish $finish "$value"

  assert_failure
}

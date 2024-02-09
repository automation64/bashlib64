setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  bl64_ans_setup || skip 'no ansible cli found'
}

@test "_bl64_ans_set_options: common globals are set" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_ans_setup
  assert_not_equal "$BL64_ANS_SET_VERBOSE" ''
  assert_not_equal "$BL64_ANS_SET_DEBUG" ''
  assert_not_equal "$BL64_ANS_SET_DIFF" ''
}

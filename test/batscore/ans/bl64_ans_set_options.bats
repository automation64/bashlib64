setup() {
  . "$DEVBL_TEST_SETUP"
  bl64_ans_setup
}

@test "bl64_ans_set_options: common globals are set" {
  assert_not_equal "$BL64_ANS_SET_VERBOSE" ''
  assert_not_equal "$BL64_ANS_SET_DEBUG" ''
  assert_not_equal "$BL64_ANS_SET_DIFF" ''
}

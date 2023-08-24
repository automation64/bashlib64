setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "_bl64_txt_set_options: common globals are set" {

  assert_not_equal "$BL64_TXT_SET_AWS_FS" ''
  assert_not_equal "$BL64_TXT_SET_GREP_ERE" ''
  assert_not_equal "$BL64_TXT_SET_GREP_INVERT" ''
  assert_not_equal "$BL64_TXT_SET_GREP_NO_CASE" ''
  assert_not_equal "$BL64_TXT_SET_GREP_QUIET" ''
  assert_not_equal "$BL64_TXT_SET_GREP_SHOW_FILE_ONLY" ''
  assert_not_equal "$BL64_TXT_SET_GREP_STDIN" ''
  assert_not_equal "$BL64_TXT_SET_SED_EXPRESSION" ''
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

}

@test "_bl64_rxtx_set_options: options are set" {
  assert_not_equal "$BL64_RXTX_SET_CURL_HEADER" ''
  assert_not_equal "$BL64_RXTX_SET_CURL_INCLUDE" ''
  assert_not_equal "$BL64_RXTX_SET_CURL_NO_PROGRESS" ''
  assert_not_equal "$BL64_RXTX_SET_CURL_OUTPUT" ''
  assert_not_equal "$BL64_RXTX_SET_CURL_REDIRECT" ''
  assert_not_equal "$BL64_RXTX_SET_CURL_REQUEST" ''
  assert_not_equal "$BL64_RXTX_SET_CURL_SECURE" ''
  assert_not_equal "$BL64_RXTX_SET_CURL_SILENT" ''
  assert_not_equal "$BL64_RXTX_SET_CURL_VERBOSE" ''
  assert_not_equal "$BL64_RXTX_SET_WGET_OUTPUT" ''
  assert_not_equal "$BL64_RXTX_SET_WGET_SECURE" ''
  assert_not_equal "$BL64_RXTX_SET_WGET_VERBOSE" ''
}

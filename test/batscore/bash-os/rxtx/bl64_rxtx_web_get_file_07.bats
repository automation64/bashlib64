setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  _bl64_rxtx_web_get_file_destination="$(mktemp -d)"
  _bl64_rxtx_web_get_file_source="$DEV_TEST_VALUE_GIT_RAW_URL"
  export _bl64_rxtx_web_get_file_destination
  export _bl64_rxtx_web_get_file_source
}

@test "bl64_rxtx_web_get_file: download file + replace off + no old content" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_rxtx_web_get_file "$_bl64_rxtx_web_get_file_source" "${_bl64_rxtx_web_get_file_destination}/test"
  assert_success

}

teardown() {
  [[ -d "$_bl64_rxtx_web_get_file_destination" ]] && rm -Rf "$_bl64_rxtx_web_get_file_destination"
}

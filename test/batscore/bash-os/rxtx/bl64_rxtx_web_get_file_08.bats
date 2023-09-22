setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  _bl64_rxtx_web_get_file_destination="$(mktemp -d)"
  _bl64_rxtx_web_get_file_source="$DEV_TEST_VALUE_GIT_RAW_URL"
  export _bl64_rxtx_web_get_file_destination
  export _bl64_rxtx_web_get_file_source
}

teardown() {

  [[ -d "$_bl64_rxtx_web_get_file_destination" ]] && rm -Rf "$_bl64_rxtx_web_get_file_destination"

}

@test "bl64_rxtx_web_get_file: download file + replace off + no old content + set perm" {

  run bl64_rxtx_web_get_file "$_bl64_rxtx_web_get_file_source" "${_bl64_rxtx_web_get_file_destination}/test" "$BL64_VAR_OFF" '0600'
  assert_success

}

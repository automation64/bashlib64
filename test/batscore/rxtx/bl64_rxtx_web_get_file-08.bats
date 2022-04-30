setup() {
  . "$DEVBL_TEST_SETUP"

  _bl64_rxtx_web_get_file_destination="$(mktemp -d)"
  _bl64_rxtx_web_get_file_source='https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash'
  export _bl64_rxtx_web_get_file_destination
  export _bl64_rxtx_web_get_file_source
}

teardown() {

  [[ -d "$_bl64_rxtx_web_get_file_destination" ]] && rm -Rf "$_bl64_rxtx_web_get_file_destination"

}

@test "bl64_rxtx_web_get_file: download file + replace off + no old content + set perm" {

  run bl64_rxtx_web_get_file "$_bl64_rxtx_web_get_file_source" "${_bl64_rxtx_web_get_file_destination}/test" "$BL64_LIB_VAR_OFF" '0600'
  assert_success

}

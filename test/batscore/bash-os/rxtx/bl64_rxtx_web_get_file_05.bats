setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  _bl64_rxtx_web_get_file_destination="$(mktemp -d)"
  _bl64_rxtx_web_get_file_source='https://raw.githubusercontent.com="$DEVBL_TEST_VALUE_GIT_RAW_URL"bashlib64/main/bashlib64.bash'
  export _bl64_rxtx_web_get_file_destination
  export _bl64_rxtx_web_get_file_source
}

teardown() {

  [[ -d "$_bl64_rxtx_web_get_file_destination" ]] && rm -Rf "$_bl64_rxtx_web_get_file_destination"

}

@test "bl64_rxtx_web_get_file: fail download file + replace on" {

  run bl64_rxtx_web_get_file "xx$_bl64_rxtx_web_get_file_source" "${_bl64_rxtx_web_get_file_destination}/test" "$BL64_VAR_ON"
  assert_failure

}

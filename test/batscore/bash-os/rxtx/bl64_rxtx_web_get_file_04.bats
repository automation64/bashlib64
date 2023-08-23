setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  _bl64_rxtx_web_get_file_destination="$(mktemp -d)"
  _bl64_rxtx_web_get_file_source="$DEVBL_TEST_VALUE_GIT_RAW_URL"
  export _bl64_rxtx_web_get_file_destination
  export _bl64_rxtx_web_get_file_source
}

teardown() {

  [[ -d "$_bl64_rxtx_web_get_file_destination" ]] && rm -Rf "$_bl64_rxtx_web_get_file_destination"

}

@test "bl64_rxtx_web_get_file: fail download file + replace off" {

  run bl64_rxtx_web_get_file "xx$_bl64_rxtx_web_get_file_source" "${_bl64_rxtx_web_get_file_destination}/test"
  assert_failure

}

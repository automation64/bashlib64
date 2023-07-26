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

@test "bl64_rxtx_web_get_file: download file + replace off + old content" {

  sample="${TESTMANSH_TEST_SAMPLES}/text_01.txt"
  test_file="${_bl64_rxtx_web_get_file_destination}/test"
  cat "$sample" > "$test_file"

  run bl64_rxtx_web_get_file "$_bl64_rxtx_web_get_file_source" "$test_file"
  assert_success

  run diff "$sample" "$test_file"
  assert_success

}

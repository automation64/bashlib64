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

@test "bl64_rxtx_web_get_file: download file + replace on + old content" {

  sample="${TESTMANSH_TEST_SAMPLES}/text_01.txt"
  test_file="${_bl64_rxtx_web_get_file_destination}/test"
  cat "$sample" > "$test_file"

  run bl64_rxtx_web_get_file "$_bl64_rxtx_web_get_file_source" "$test_file" "$BL64_VAR_ON"
  assert_success

  run diff "$sample" "$test_file"
  assert_failure

}

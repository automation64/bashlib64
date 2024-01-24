setup() {
  _bl64_rxtx_web_get_file_destination="$(mktemp -d)"
  _bl64_rxtx_web_get_file_source="$DEV_TEST_VALUE_GIT_RAW_URL"
  export _bl64_rxtx_web_get_file_destination
  export _bl64_rxtx_web_get_file_source
}

teardown() {

  [[ -d "$_bl64_rxtx_web_get_file_destination" ]] && rm -Rf "$_bl64_rxtx_web_get_file_destination"

}

@test "bl64_rxtx_web_get_file: fail download file + replace on + old content" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  sample="${TESTMANSH_TEST_SAMPLES}/text_01.txt"
  test_file="${_bl64_rxtx_web_get_file_destination}/test"
  cat "$sample" > "$test_file"

  run bl64_rxtx_web_get_file "xx$_bl64_rxtx_web_get_file_source" "$test_file" "$BL64_VAR_ON"
  assert_failure

  run diff "$sample" "$test_file"
  assert_success

}

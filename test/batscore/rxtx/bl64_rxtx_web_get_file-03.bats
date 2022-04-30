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

@test "bl64_rxtx_web_get_file: download file + replace on + old content" {

  sample="${DEVBL_SAMPLES}/text_01.txt"
  test_file="${_bl64_rxtx_web_get_file_destination}/test"
  cat "$sample" > "$test_file"

  run bl64_rxtx_web_get_file "$_bl64_rxtx_web_get_file_source" "$test_file" "$BL64_LIB_VAR_ON"
  assert_success

  run diff "$sample" "$test_file"
  assert_failure

}

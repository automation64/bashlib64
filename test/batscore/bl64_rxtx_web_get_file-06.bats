setup() {
  . "$DEVBL_TEST_BASHLIB64"
  . "${DEVBL_BATS_HELPER}/bats-support/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-assert/load.bash"
  . "${DEVBL_BATS_HELPER}/bats-file/load.bash"

  _bl64_rxtx_web_get_file_destination="$(mktemp -d)"
  _bl64_rxtx_web_get_file_source='https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash'
  export _bl64_rxtx_web_get_file_destination
  export _bl64_rxtx_web_get_file_source
  set +u # to avoid IFS missing error in run function
}

teardown() {

  [[ -d "$_bl64_rxtx_web_get_file_destination" ]] && rm -Rf "$_bl64_rxtx_web_get_file_destination"

}

@test "bl64_rxtx_web_get_file: fail download file + replace on + old content" {

  sample="${DEVBL_SAMPLES}/text_01.txt"
  test_file="${_bl64_rxtx_web_get_file_destination}/test"
  cat "$sample" > "$test_file"

  run bl64_rxtx_web_get_file "xx$_bl64_rxtx_web_get_file_source" "$test_file" "$BL64_LIB_VAR_ON"
  assert_failure

  run diff "$sample" "$test_file"
  assert_success

}

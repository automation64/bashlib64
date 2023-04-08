setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  _bl64_rxtx_web_get_file_destination="$(mktemp -d)"
  _bl64_rxtx_web_get_file_source='https://raw.githubusercontent.com/serdigital64/bashlib64/main/bashlib64.bash'
  export _bl64_rxtx_web_get_file_destination
  export _bl64_rxtx_web_get_file_source
}

@test "bl64_rxtx_web_get_file: parameters are not present" {
  run bl64_rxtx_web_get_file
  assert_failure
}

@test "bl64_rxtx_web_get_file: 2nd parameter is not present" {
  run bl64_rxtx_web_get_file '/dev/null'
  assert_failure
}
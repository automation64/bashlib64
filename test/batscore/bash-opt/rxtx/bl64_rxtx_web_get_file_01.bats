@test "bl64_rxtx_web_get_file: function parameter missing" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rxtx_web_get_file
  assert_failure
}

@test "bl64_rxtx_web_get_file: 2nd parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_rxtx_web_get_file '/dev/null'
  assert_failure
}

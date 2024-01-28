@test "bl64_api_url_encode: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_api_url_encode
  assert_failure
}

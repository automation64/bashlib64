setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_api_url_encode: parameters are not present" {
  run bl64_api_url_encode
  assert_failure
}

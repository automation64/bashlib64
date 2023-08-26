setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_api_call: parameters are not present" {
  run bl64_api_call
  assert_failure
}

@test "bl64_api_call: 2 parameter is not present" {
  run bl64_api_call 'https://xxx'
  assert_failure
}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_gcp_secret_get: no args" {
  run bl64_gcp_secret_get
  assert_failure
}

@test "bl64_gcp_secret_get: no version" {
  run bl64_gcp_secret_get 'test-secret'
  assert_failure
}

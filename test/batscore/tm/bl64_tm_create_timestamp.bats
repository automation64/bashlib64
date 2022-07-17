setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_tm_create_timestamp: get timestamp" {

  run bl64_tm_create_timestamp
  assert_success
}

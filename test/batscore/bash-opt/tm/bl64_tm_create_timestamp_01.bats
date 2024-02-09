@test "bl64_tm_create_timestamp: get timestamp" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_tm_create_timestamp
  assert_success
}

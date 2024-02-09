@test "bl64_tm_create_timestamp_file: get timestamp" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"


  run bl64_tm_create_timestamp_file
  assert_success
}

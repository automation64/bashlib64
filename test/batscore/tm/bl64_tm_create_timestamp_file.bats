setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_tm_create_timestamp_file: get timestamp" {


  run bl64_tm_create_timestamp_file
  assert_success
}

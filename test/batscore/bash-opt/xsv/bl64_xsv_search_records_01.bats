@test "bl64_xsv_search_records: command parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_xsv_search_records
  assert_failure

}

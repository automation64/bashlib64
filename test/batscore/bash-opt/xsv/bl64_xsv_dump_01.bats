@test "bl64_xsv_dump: parameter is not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"

  run bl64_xsv_dump
  assert_failure

}

setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_xsv_dump: parameter is not present" {

  run bl64_xsv_dump
  assert_failure

}

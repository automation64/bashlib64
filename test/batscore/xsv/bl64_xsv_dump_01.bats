setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_xsv_dump: parameter is not present" {

  run bl64_xsv_dump
  assert_failure

}

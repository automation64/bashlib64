setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_xsv_setup: module setup" {
  run bl64_xsv_setup
  assert_success
}

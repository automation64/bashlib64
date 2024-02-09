@test "bl64_xsv_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_xsv_setup
  assert_success
}

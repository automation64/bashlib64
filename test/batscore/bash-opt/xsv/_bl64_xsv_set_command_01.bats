@test "_bl64_xsv_set_command: set command" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_xsv_set_command
  assert_success
}

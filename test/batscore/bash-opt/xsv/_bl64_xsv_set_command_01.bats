setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "_bl64_xsv_set_command: set command" {
  run _bl64_xsv_set_command
  assert_success
}

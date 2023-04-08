setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_command: parameter is not present" {

  run bl64_check_command
  assert_failure

}

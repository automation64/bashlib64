setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_directory: directory parameter is not present" {

  run bl64_check_directory
  assert_failure

}

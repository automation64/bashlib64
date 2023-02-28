setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_file: file parameter is not present" {

  run bl64_check_file
  assert_failure

}

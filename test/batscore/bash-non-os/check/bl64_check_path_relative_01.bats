setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_path_relative: parameter is not present" {

  run bl64_check_path_relative
  assert_failure

}

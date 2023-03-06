setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_path: parameter is not present" {

  run bl64_check_path
  assert_failure

}


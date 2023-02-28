setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_module: parameter is not present" {

  run bl64_check_module
  assert_failure

}


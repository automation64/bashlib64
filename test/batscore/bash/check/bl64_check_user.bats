setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_user: parameter is not present" {

  run bl64_check_user
  assert_failure

}


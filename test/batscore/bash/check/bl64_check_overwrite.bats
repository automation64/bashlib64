setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_overwrite: parameter is not present" {

  run bl64_check_overwrite
  assert_failure

}

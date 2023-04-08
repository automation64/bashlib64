setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_check_path_not_present: parameter not present" {

  run bl64_check_path_not_present
  assert_failure

}

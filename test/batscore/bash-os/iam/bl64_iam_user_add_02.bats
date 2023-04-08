setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  bl64_iam_setup
}

@test "bl64_iam_user_add: root privilege" {
  run bl64_iam_user_add
  assert_failure
}

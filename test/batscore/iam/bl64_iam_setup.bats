setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_iam_setup: module setup" {
  run bl64_iam_setup
  assert_success
}

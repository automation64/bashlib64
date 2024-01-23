@test "bl64_iam_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_iam_setup
  assert_success
}

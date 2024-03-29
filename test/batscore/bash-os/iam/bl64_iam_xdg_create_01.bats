@test "bl64_iam_xdg_create: parameters are not present" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_iam_xdg_create
  assert_failure
}

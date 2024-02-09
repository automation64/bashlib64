@test "_bl64_iam_set_alias: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_iam_set_alias
  assert_success
}

setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_iam_set_alias: run function" {
  run bl64_iam_set_alias
  assert_success
}

setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_iam_set_command: run function" {
  run bl64_iam_set_command
  assert_success
}

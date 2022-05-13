setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_ans_setup: module setup" {
  run bl64_ans_setup
  assert_success
}

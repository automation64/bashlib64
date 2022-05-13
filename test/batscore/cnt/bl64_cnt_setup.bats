setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_cnt_setup: module setup" {
  run bl64_cnt_setup
  assert_success
}

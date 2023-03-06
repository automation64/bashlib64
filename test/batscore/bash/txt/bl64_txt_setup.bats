setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_txt_setup: module setup" {
  run bl64_txt_setup
  assert_success
}

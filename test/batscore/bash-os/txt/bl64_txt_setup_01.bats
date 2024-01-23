@test "bl64_txt_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_txt_setup
  assert_success
}

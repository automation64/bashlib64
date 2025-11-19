@test "bl64_fmt_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_fmt_setup
  assert_success
}

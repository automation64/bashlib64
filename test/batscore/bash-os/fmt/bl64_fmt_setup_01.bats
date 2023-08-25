setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_fmt_setup: module setup" {
  run bl64_fmt_setup
  assert_success
}

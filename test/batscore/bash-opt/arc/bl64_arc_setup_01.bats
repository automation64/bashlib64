setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "bl64_arc_setup: module setup" {
  run bl64_arc_setup
  assert_success
}

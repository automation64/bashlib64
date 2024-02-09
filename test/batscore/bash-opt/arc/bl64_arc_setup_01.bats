@test "bl64_arc_setup: module setup" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run bl64_arc_setup
  assert_success
}

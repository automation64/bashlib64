@test "_bl64_arc_set_options: run function" {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
  run _bl64_arc_set_options
  assert_success
}

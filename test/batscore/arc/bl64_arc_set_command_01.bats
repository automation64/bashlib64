setup() {
  . "$TESTMANSH_TEST_BATSCORE_SETUP"
}

@test "_bl64_arc_set_command: run function" {
  run _bl64_arc_set_command
  assert_success
}

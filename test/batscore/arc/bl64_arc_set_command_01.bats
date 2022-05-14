setup() {
  . "$DEVBL_TEST_SETUP"
}

@test "bl64_arc_set_command: run function" {
  run bl64_arc_set_command
  assert_success
}
